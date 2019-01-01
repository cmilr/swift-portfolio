//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Cary Miller on 8/14/18.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var activationDate: NSDate?
    @NSManaged public var categorySessionsCompleted: Int16
    @NSManaged public var daysElapsed: Int16
    @NSManaged public var iconIndex: Int16
    @NSManaged public var index: Int16
    @NSManaged public var intervalAmount: Int16
    @NSManaged public var intervalType: Int16
    @NSManaged public var lastSessionCheck: NSDate?
    @NSManaged public var metronome: Bool
    @NSManaged public var sessionComplete: Bool
    @NSManaged public var title: String?
    @NSManaged public var guiSessionCount: Int16
    @NSManaged public var activeExercise: Exercise?
    @NSManaged public var exercises: NSOrderedSet?

}

// MARK: Generated accessors for exercises
extension Category {

    @objc(insertObject:inExercisesAtIndex:)
    @NSManaged public func insertIntoExercises(_ value: Exercise, at idx: Int)

    @objc(removeObjectFromExercisesAtIndex:)
    @NSManaged public func removeFromExercises(at idx: Int)

    @objc(insertExercises:atIndexes:)
    @NSManaged public func insertIntoExercises(_ values: [Exercise], at indexes: NSIndexSet)

    @objc(removeExercisesAtIndexes:)
    @NSManaged public func removeFromExercises(at indexes: NSIndexSet)

    @objc(replaceObjectInExercisesAtIndex:withObject:)
    @NSManaged public func replaceExercises(at idx: Int, with value: Exercise)

    @objc(replaceExercisesAtIndexes:withExercises:)
    @NSManaged public func replaceExercises(at indexes: NSIndexSet, with values: [Exercise])

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSOrderedSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSOrderedSet)

}
