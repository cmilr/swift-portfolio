//
//  CoreLogic.swift
//  Dalilah
//
//  Created by Cary Miller on 11/8/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import CoreData

class CoreLogic {
   private let coreDataStack: CoreDataStack
   private let userDefaultsStack: UserDefaultsStack
   var categories: NSFetchedResultsController<Category>!
   let calendar = NSCalendar.current

   init(coreDataStack: CoreDataStack, userDefaultsStack: UserDefaultsStack) {
      self.coreDataStack = coreDataStack
      self.userDefaultsStack = userDefaultsStack
      self.categories = fetchCategories()
   }

   func fetchCategories() -> NSFetchedResultsController<Category> {
      let managedContext = coreDataStack.context
      let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
      let sort = NSSortDescriptor(key: #keyPath(Category.index), ascending: true)
      fetchRequest.sortDescriptors = [sort]
      fetchRequest.returnsObjectsAsFaults = false

      let fetchedResultsController = NSFetchedResultsController(
         fetchRequest: fetchRequest,
         managedObjectContext: managedContext,
         sectionNameKeyPath: nil,
         cacheName: nil)

      do {
         try fetchedResultsController.performFetch()
      } catch let error as NSError {
         print("Fetching error: \(error), \(error.userInfo)")
      }
      return fetchedResultsController
   }

   private func validate(_ categories: NSFetchedResultsController<Category>) {
      guard let fetchedObjects = categories.fetchedObjects else {
         return
      }
      for category in fetchedObjects {
         if category.title.isNilOrEmpty {
            category.requestDeletion()
            print("Category deleted: title was empty.")
            continue
         }
         guard let firstExercise = category.exercises?.array.first else {
            print("Category deleted: Exercises were empty.")
            category.requestDeletion()
            continue
         }
         let exercise = firstExercise as! Exercise
         if exercise.title.isNilOrEmpty {
            print("Category deleted: Exercise title was empty.")
            category.requestDeletion()
            continue
         }
         if category.activeExercise == nil {
            category.setActiveExerciseIfNil()
            print("ActiveExercise was found to be nil: it has been reset.")
         }
         if category.activationDate == nil {
            category.setActivationDate()
            print("ActivationDate was found to be nil: it has been reset.")
         }
      }
   }

   func refreshCategories() {
      self.categories = fetchCategories()
   }

   // MARK: - Core Business Logic
   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   func calculateIntervalsAndDates() {
      refreshCategories()
      guard let fetchedObjects = categories.fetchedObjects else {
         fatalError("No objects could be fetched.")
      }
      for category in fetchedObjects {
         let type = Int(category.intervalType)
         switch type {
         case days:
            handleDays(for: category)
         case activeDays:
            handleActiveDays(for: category)
         case manual:
            break
         default:
            fatalError("Unknown interval type")
         }
      }
      coreDataStack.save()
   }

   private func handleDays(for category: Category) {
      /*
       In this context: activationDate is used to track both the actual and
       virtual dates that a category was activated. This is easiest to explain
       with an example:

       If the interval is set to seven days, and the app doesn't get opened for
       ten days, activationDate gets set for seven days out, not ten. In this
       example it is used to specifically keep track of where those 7-day
       activations would've occurred.
       */
      guard let activationDate = category.activationDate as Date? else {
            print("Error: activationDate could not be retrieved")
         return
      }
      guard let lastSessionCheck = category.lastSessionCheck as Date? else {
            print("Error: lastSessionCheck could not be retrieved")
            return
      }

      if numDaysElapsed(from: lastSessionCheck, to: DateKit.now()) >= 1 {
         category.sessionComplete = false
         category.lastSessionCheck = DateKit.now() as NSDate
         incrementSessionStatCounts(for: category)
      }

      let interval = category.intervalAmount
      category.daysElapsed = Int16(numDaysElapsed(from: activationDate, to: DateKit.now()))
      
      if category.daysElapsed >= interval {
         let intervalsElapsed = category.daysElapsed / interval
         let remainingDays = category.daysElapsed % interval
         let fetchedExercises = category.fetchExercises()

         guard let fetchedObjects = fetchedExercises.fetchedObjects,
            let activeIndex = category.activeExercise?.index,
            let count = category.exercises?.count else {
               return
         }

         // Calculate and set new active exercise.
         var index = Int(activeIndex)
         for _ in 1...intervalsElapsed {
            index = Int(index + 1 >= count ? 0 : index + 1)
         }
         let newActiveEx = fetchedObjects.filter { $0.index == index }
         if let firstNewActiveEx = newActiveEx.first {
            category.setActiveExercise(to: firstNewActiveEx)
         } else {
            print("New active exercise wasn't found for \"\(category.title ?? "category")\"")
         }

         // Calculate new activation date.
         let currentDate = DateKit.now()
         var component = DateComponents()
         component.day = Int(-remainingDays)
         let newActivationDate = Calendar.current.date(byAdding: component, to: currentDate)
         category.activationDate = newActivationDate! as NSDate
         category.daysElapsed = remainingDays
      }
   }

   private func handleActiveDays(for category: Category) {
      /*
       In this context: each day the app is launched, activationDate gets reset.
       It can then be checked against on the next launch to test that at least
       one full day has passed. This is all it's used for.

       If at least one day HAS passed since the last time the category was
       checked, and the session is also marked as complete, we increment the
       number of days elapsed and reset sessionComplete to false.
       */
      guard let activationDate = category.activationDate else {
         return
      }
      guard numDaysElapsed(from: activationDate as Date, to: DateKit.now()) >= 1 else {
         return
      }
      category.setActivationDate()

      if category.sessionComplete {
         category.daysElapsed += 1
         category.sessionComplete = false
         incrementSessionStatCounts(for: category)
         /*
          If number of days elapsed >= the interval amount
          requested by the user, then increment the active
          exercise as well.
          */
         if category.daysElapsed >= category.intervalAmount {
            let fetchedExercises = category.fetchExercises()
            guard let fetchedObjects = fetchedExercises.fetchedObjects,
               let activeIndex = category.activeExercise?.index,
               let count = category.exercises?.count else {
                  return
            }
            let index = Int(activeIndex + 1 >= count ? 0 : activeIndex + 1)
            let newActiveEx = fetchedObjects.filter { $0.index == index }
            category.setActiveExercise(to: newActiveEx[0])
            category.daysElapsed = 0
            category.guiSessionCount = 0
         }
      }
   }

   private func incrementSessionStatCounts(for category: Category) {
      guard let activeExercise = category.activeExercise else {
         print("Error: active exercise could not be found")
         return
      }
      category.categorySessionsCompleted += 1
      activeExercise.exerciseSessionsCompleted += 1
   }

   func handleManualRotationIfRequired(for category: Category) {
      if category.intervalType == manual {
         let fetchedExercises = category.fetchExercises()
         guard let fetchedObjects = fetchedExercises.fetchedObjects,
            let activeIndex = category.activeExercise?.index,
            let count = category.exercises?.count else {
               return
         }
         let index = Int(activeIndex + 1 >= count ? 0 : activeIndex + 1)
         let newActiveEx = fetchedObjects.filter { $0.index == index }
         category.setActiveExercise(to: newActiveEx[0])
         category.sessionComplete = false
      }
   }
}
