//
//  Exercise+CoreDataClass.swift
//  
//
//  Created by Cary Miller on 10/18/17.
//
//

import Foundation
import CoreData

@objc(Exercise)
public class Exercise: NSManagedObject {

   func delete() {
      guard let managedContext = self.managedObjectContext else {
         fatalError("Could not retrieve NSManagedObjectContext.")
      }
      managedContext.delete(self)
   }

}
