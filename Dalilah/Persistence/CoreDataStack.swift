//
//  CoreDataStack.swift
//  Dalilah
//
//  Created by Cary Miller on 10/20/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
   lazy var context: NSManagedObjectContext = {
      return self.container.viewContext
   }()

   lazy var container: NSPersistentContainer = {
      let container = NSPersistentContainer(name: self.modelName)
      container.loadPersistentStores { (_, error) in
         if let error = error as NSError? {
            print("Unresolved error \(error), \(error.userInfo)")
         }
      }
      return container
   }()

   let modelName: String

   init(modelName: String) {
      self.modelName = modelName
   }

   func add(_ managedObject: NSManagedObject) {
      context.insert(managedObject)
   }

   func delete(_ managedObject: NSManagedObject) {
      context.delete(managedObject)
   }

   func save() {
      guard context.hasChanges else { return }
      context.mergePolicy = NSOverwriteMergePolicy
      do {
         try context.save()
      } catch let error as NSError {
         print("Unresolved error \(error), \(error.userInfo)")
      }
   }

   func entityIsEmpty(_ entity: String) -> Bool {
      do {
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
         let count = try context.count(for: request)
         return count == 0 ? true : false
      } catch {
         return true
      }
   }

   func wipe(_ entity: String) {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      do {
         try context.execute(batchDeleteRequest)
      } catch let error as NSError {
         print("Could not destroy records. \(error), \(error.userInfo)")
      }
   }
}
