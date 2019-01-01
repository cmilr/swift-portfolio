//
//  Exercise+CoreDataProperties.swift
//  
//
//  Created by Cary Miller on 8/8/18.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var exerciseSessionsCompleted: Int16
    @NSManaged public var index: Int16
    @NSManaged public var speed: Int16
    @NSManaged public var title: String?
    @NSManaged public var notes: String?
    @NSManaged public var activeExerciseInverse: Category?
    @NSManaged public var category: Category?

}
