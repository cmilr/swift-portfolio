//
//  FetchedResults+Ext.swift
//  Dalilah
//
//  Created by Cary Miller on 1/5/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import CoreData

public extension NSFetchedResultsController {
   
   @objc func createNewCategory() -> Category {
      let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: self.managedObjectContext) as! Category
      return category
   }

   @objc func initializeNewCategory() -> Category {
      let category = self.createNewCategory()
      category.addTempExercises()

      guard let activeExercise = category.exercises?.object(at: 0) as? Exercise else {
         fatalError("Undefined State: exercise at [0] could not be found.")
      }
      category.setActiveExercise(to: activeExercise)
      category.setActivationDate()
      category.intervalAmount = 1
      category.intervalType = Int16(days)
      category.index = Int16(self.sections![0].numberOfObjects)
      self.save()
      return category
   }

   @objc public func sectionCount() -> Int {
      if self.sections == nil {
         return 0
      }
      return self.sections!.count
   }

   @objc func save() {
      guard self.managedObjectContext.hasChanges else { return }
      do {
         try self.managedObjectContext.save()
      } catch let error as NSError {
         print("Unresolved error \(error), \(error.userInfo)")
      }
   }

   @objc func delete(_ managedObject: NSManagedObject) {
      self.managedObjectContext.delete(managedObject)
   }

   @objc func syncToTableView(_ categories: NSFetchedResultsController<Category>, _ source: IndexPath, _ destination: IndexPath) {
      guard let fetchedObjects = categories.fetchedObjects else {
         return
      }
      var reorderArray: [Category] = fetchedObjects
      let category = categories.object(at: source)
      reorderArray.remove(at: source.row)
      reorderArray.insert(category, at: destination.row)

      for (index, category) in reorderArray.enumerated() {
         category.index = Int16(index)
      }
      categories.save()
   }

   @objc func syncToTableView(_ categories: NSFetchedResultsController<Category>) {
      guard let fetchedObjects = categories.fetchedObjects else {
         return
      }
      var i: Int16 = 0
      for category in fetchedObjects where i < fetchedObjects.count {
         category.index = i
         i += 1
      }
      save()
   }
}
