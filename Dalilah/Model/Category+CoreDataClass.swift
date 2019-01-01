//
//  Category+CoreDataClass.swift
//  
//
//  Created by Cary Miller on 10/18/17.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {

   // MARK: - Public Methods
   func setActiveExercise(to exercise: Exercise) {
      activeExercise = exercise
      activationDate = DateKit.now() as NSDate
      lastSessionCheck = DateKit.now() as NSDate
      save()
   }

   func setActivationDate() {
      activationDate = DateKit.now() as NSDate
      lastSessionCheck = DateKit.now() as NSDate
      save()
   }

   func setMockActivationDate(to date: NSDate) {
      activationDate = date
      lastSessionCheck = date
      save()
   }

   func setIntervalType(_ type: Int16) {
      if type != intervalType {
         intervalType = type
         activationDate = DateKit.now() as NSDate
         lastSessionCheck = DateKit.now() as NSDate
         sessionComplete = false
         daysElapsed = Int16(0)
         guiSessionCount = 0
         save()
      }
   }

   func incrementGUISessionCount() {
      guiSessionCount += 1
      if guiSessionCount > intervalAmount {
         guiSessionCount = intervalAmount
      }
      save()
   }

   func decrementGUISessionCount() {
      guiSessionCount -= 1
      if guiSessionCount < 0 {
         guiSessionCount = 0
      }
      save()
   }

   func createNewExercise() -> Exercise {
      guard let managedContext = self.managedObjectContext else {
         fatalError("Could not retrieve NSManagedObjectContext.")
      }
      let newExercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: managedContext) as! Exercise
      return newExercise
   }

   func addTempExercises() {
      guard let exercises = self.exercises else {
         print("Category contains no exercises.")
         return
      }
      let initialCount = exercises.count
      let numToPad = detailTableViewPadding
      let total = initialCount + numToPad
      for index in initialCount..<total {
         let newExercise = createNewExercise()
         newExercise.index = Int16(index)
         newExercise.title = ""
         addToExercises(newExercise)
      }
      save()
   }

   func addNewExerciseToPadTableView() {
      guard let exercises = self.exercises else {
         print("Category contains no exercises.")
         return
      }
      let index = exercises.count
      let newExercise = createNewExercise()
      newExercise.index = Int16(index)
      newExercise.title = ""
      addToExercises(newExercise)
      save()
   }

   func teardown() {
      // Note: this method runs when transitioning from the Detail
      // screen back to the Master screen, for ALL categories, whether
      // pre-existing or brand new.
      guard !self.title.isNilOrEmpty else {
         delete()
         return
      }
      removeEmptyExercises()
      updateExerciseIndexes()
      configureCategoryIfNew()
   }

   func configureCategoryIfNew() {
      if self.title.isNilOrEmpty {
         return
      }
      if self.activeExercise == nil {
         let newActiveExercise = exercises?.object(at: 0)
         activeExercise = newActiveExercise as? Exercise
      }
      if activationDate == nil {
         activationDate = DateKit.now() as NSDate
      }
      save()
   }

   func setActiveExerciseIfNil() {
      if self.title.isNilOrEmpty {
         return
      }
      if self.activeExercise == nil {
         let newActiveExercise = exercises?.object(at: 0)
         activeExercise = newActiveExercise as? Exercise
      }
      save()
   }

   func deleteExercise(from exercises: NSFetchedResultsController<Exercise>, at indexPath: IndexPath) {
      guard let exerciseCount = exercises.fetchedObjects?.count else {
         fatalError("Could not retrieve exercise count.")
      }
      if indexPath.item >= exerciseCount {
         fatalError("Index is outside range of exercises.")
      }
      let exerciseToDelete = exercises.object(at: indexPath)
      if exerciseToDelete == self.activeExercise {
         calculateNewActiveExercise(from: exercises, andPrevPath: indexPath)
      }
      exerciseToDelete.delete()
      save()
   }

   func hasTitle() -> Bool {
      return !self.title.isNilOrEmpty
   }

   func exercisesHaveData() -> Bool {
      let fetch = self.fetchExercises()
      guard let exercises = fetch.fetchedObjects else {
         return false
      }

      var status = false
      for exercise in exercises where !exercise.title.isNilOrEmpty {
         status = true
      }
      return status
   }

   func syncExercisesToTableView(_ source: IndexPath, _ destination: IndexPath) {
      let exercises = fetchExercises()
      guard let fetchedObjects = exercises.fetchedObjects else {
         return
      }
      var reorderArray: [Exercise] = fetchedObjects
      let exercise = exercises.object(at: source)
      reorderArray.remove(at: source.row)
      reorderArray.insert(exercise, at: destination.row)

      for (index, exercise) in reorderArray.enumerated() {
         exercise.index = Int16(index)
      }
      save()
   }

   func syncExercisesToTableView() {
      let exercises = fetchExercises()
      guard let fetchedObjects = exercises.fetchedObjects else {
         return
      }
      var i: Int16 = 0
      for exercise in fetchedObjects where i < fetchedObjects.count {
         exercise.index = i
         i += 1
      }
      save()
   }

   func updateSessionStatus() {
      self.sessionComplete = !self.sessionComplete
      save()
   }

   func sessionStatus() -> Bool {
      return self.sessionComplete
   }

   func fetchExercises() -> NSFetchedResultsController<Exercise> {
      guard let managedContext = self.managedObjectContext else {
         fatalError("Could not retrieve NSManagedObjectContext.")
      }
      let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
      let exercises = self.exercises?.array as! [Exercise]
      let predicate = NSPredicate(format: "self in %@", exercises)
      let sort = NSSortDescriptor(key: #keyPath(Exercise.index), ascending: true)
      fetchRequest.predicate = predicate
      fetchRequest.sortDescriptors = [sort]

      let fetchedResultsController = NSFetchedResultsController(
         fetchRequest: fetchRequest,
         managedObjectContext: managedContext,
         sectionNameKeyPath: nil,
         cacheName: "exercises")

      do {
         try fetchedResultsController.performFetch()
      } catch let error as NSError {
         print("Fetching error: \(error), \(error.userInfo)")
      }
      return fetchedResultsController
   }

   func requestDeletion() {
      delete()
   }
}

// MARK: - Private Methods
extension Category {
   private func save() {
      guard let managedContext = self.managedObjectContext,
         managedContext.hasChanges else {
            return
      }
      do {
         try managedContext.save()
      } catch let error as NSError {
         print("Unresolved error \(error), \(error.userInfo)")
      }
   }

   private func delete() {
      guard let managedContext = self.managedObjectContext else {
         fatalError("Could not retrieve NSManagedObjectContext.")
      }
      managedContext.delete(self)
      save()
   }

   private func removeEmptyExercises() {
      let fetch = fetchExercises()
      guard let exercises = fetch.fetchedObjects else {
         return
      }

      for exercise in exercises where exercise.title.isNilOrEmpty {
         removeFromExercises(exercise)
         exercise.delete()
      }
      save()
   }

   private func calculateNewActiveExercise(from exercises: NSFetchedResultsController<Exercise>, andPrevPath indexPath: IndexPath) {
      let newActiveIndexPath: IndexPath
      if indexPath.item == 0 {
         newActiveIndexPath = IndexPath(item: 1, section: 0)
      } else {
         newActiveIndexPath = IndexPath(item: 0, section: 0)
      }
      let newActiveExercise = exercises.object(at: newActiveIndexPath)
      activeExercise = newActiveExercise
      activationDate = DateKit.now() as NSDate
   }

   private func updateExerciseIndexes() {
      let fetch = fetchExercises()
      guard let exercises = fetch.fetchedObjects else {
         return
      }
      for (index, exercise) in exercises.enumerated() {
         exercise.index = Int16(index)
      }
      save()
   }
}
