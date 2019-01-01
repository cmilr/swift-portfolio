//
//  FieldManualTests.swift
//  FieldManualTests
//
//  Created by Cary Miller on 10/11/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import XCTest
import CoreData

@testable import FieldManual

class CategoryTests: XCTestCase {
   var coreDataStack: CoreDataStack!
   var userDefaultsStack: UserDefaultsStack!
   var services: Services!
   var coreLogic: CoreLogic!
   var category: FieldManual.Category!
   var exercises: NSFetchedResultsController<Exercise>!

   override func setUp() {
      super.setUp()
      coreDataStack = CoreDataStack(modelName: "FieldManualA")
      userDefaultsStack = UserDefaultsStack()
      services = Services(coreDataStack: coreDataStack, userDefaultsStack: userDefaultsStack)
      services.importJSONData(from: "category-test-data")
      coreLogic = CoreLogic(coreDataStack: coreDataStack, userDefaultsStack: userDefaultsStack)
      category = coreLogic.categories.object(at: IndexPath(item: 0, section: 0))
      exercises = category.fetchExercises()
   }

   override func tearDown() {
      coreDataStack.wipe("Category")
      coreDataStack = nil
      services = nil
      coreLogic = nil
      super.tearDown()
   }

   func testPerformance() {
//      self.measure {
//         // Call a method here
//      }
   }

   func testFetchExercises_returnsCorrectExerciseCount() {
      let expected = 15
      let actual = exercises.fetchedObjects?.count
      XCTAssertEqual(expected, actual)
   }

   func testRefreshCategories_returnsCorrectCategoryCount() {
      let initial = coreLogic.categories.fetchedObjects?.count
      _ = coreLogic.categories.createNewCategory()
      coreLogic.categories.save()
      coreLogic.refreshCategories()
      let expected = initial! + 1
      let actual = coreLogic.categories.fetchedObjects?.count
      XCTAssertEqual(expected, actual)
   }

   func testDelete_returnsCorrectCategoryCount() {
      let initial = coreLogic.categories.fetchedObjects?.count
      category.requestDeletion()
      coreLogic.refreshCategories()
      let expected = initial! - 1
      let actual = coreLogic.categories.fetchedObjects?.count
      XCTAssertEqual(expected, actual)
   }

   func testDelete_deletedCategoryReturnsFalse() {
      category.requestDeletion()
      coreLogic.refreshCategories()
      let expected = false
      let actual = coreLogic.categories.fetchedObjects?.contains(category)
      XCTAssertEqual(expected, actual)
   }

   func testAddTempExercises_exerciseCountIncreases() {
      let initial = category.exercises?.count
      category.addTempExercises()
      let expected = initial! + detailTableViewPadding
      let actual = category.exercises?.count
      XCTAssertEqual(expected, actual)
   }

   func testInitializeNewCategory_indexSetToNextAvailable() {
      let expected = coreLogic.categories.fetchedObjects?.count
      let returned = coreLogic.categories.initializeNewCategory()
      let actual = Int(returned.index)
      XCTAssertEqual(expected, actual)
   }

   func testInitializeNewCategory_returnsCorrectExerciseCount() {
      let returned = coreLogic.categories.initializeNewCategory()
      let expected = detailTableViewPadding
      let actual = returned.exercises?.count
      XCTAssertEqual(expected, actual)
   }

   func testTeardown_removesAllEmptyExercises() {
      let expected = category.exercises?.count
      category.addTempExercises()
      category.teardown()
      let actual = category.exercises?.count
      XCTAssertEqual(expected, actual)
   }

   func testTeardown_doesNotRemoveValidExercises() {
      let expected = category.exercises?.count
      category.teardown()
      let actual = category.exercises?.count
      XCTAssertEqual(expected, actual)
   }

   func testHasTitle_returnsTrueIfCategoryHasTitle() {
      let expected = true
      let actual = category.hasTitle()
      XCTAssertEqual(expected, actual)
   }

   func testHasTitle_returnsFalseIfCategoryHasNoTitle() {
      category.title = ""
      let expected = false
      let actual = category.hasTitle()
      XCTAssertEqual(expected, actual)
   }

   func testHasTitle_returnsFalseIfCategoryTitleIsNil() {
      category.title = nil
      let expected = false
      let actual = category.hasTitle()
      XCTAssertEqual(expected, actual)
   }

   func testExercisesHaveData_returnsTrueIfExercisesHaveData() {
      let expected = true
      let actual = category.exercisesHaveData()
      XCTAssertEqual(expected, actual)
   }

   func testSyncExercisesToTableView_ascending_returnsInProperOrder() {
      // Select an Exercise and move it to a new slot
      let source = IndexPath(item: 4, section: 0)
      let destination = IndexPath(item: 2, section: 0)
      category.syncExercisesToTableView(source, destination)

      // Refresh the Exercises list
      exercises = category.fetchExercises()

      // Pick a different Exercise, and test it
      let testPath = IndexPath(item: 4, section: 0)
      let exercise = exercises.object(at: testPath)
      let actual = exercise.title
      let expected = "Exercise 1.4"
      XCTAssertEqual(expected, actual)
   }

   func testSyncExercisesToTableView_descending_returnsInProperOrder() {
      // Select an Exercise and move it to a new slot
      let source = IndexPath(item: 6, section: 0)
      let destination = IndexPath(item: 12, section: 0)
      category.syncExercisesToTableView(source, destination)

      // Refresh the Exercises list
      exercises = category.fetchExercises()

      // Pick a different Exercise, and test it
      let testPath = IndexPath(item: 10, section: 0)
      let exercise = exercises.object(at: testPath)
      let actual = exercise.title
      let expected = "Exercise 1.12"
      XCTAssertEqual(expected, actual)
   }

   func testDeleteExercise_deletesProperExercise() {
      // Get an Exercise, then delete it
      let indexPath = IndexPath(item: 9, section: 0)
      let deleted = exercises.object(at: indexPath)
      category.deleteExercise(from: exercises, at: indexPath)

      // Refresh the Exercises list, then test
      exercises = category.fetchExercises()
      let result = exercises.fetchedObjects?.contains(deleted)
      XCTAssertFalse(result!)
   }

   func testDeleteExercise_whenActiveExerciseIsFirstItem_assignsNewActiveExercise() {
      // Set index paths
      let initialActiveIndexPath = IndexPath(item: 0, section: 0)
      let nextActiveIndexPath = IndexPath(item: 1, section: 0)

      // Get next active exercise, then delete initial active exercise
      let expected = exercises.object(at: nextActiveIndexPath)
      category.deleteExercise(from: exercises, at: initialActiveIndexPath)

      // Refresh the Exercises list, then test
      exercises = category.fetchExercises()
      let actual = category.activeExercise
      XCTAssertEqual(expected, actual)
   }

   func testDeleteExercise_whenActiveExerciseIsMiddleItem_assignsNewActiveExercise() {
      // Set initial active exercise
      let initialActiveIndexPath = IndexPath(item: 8, section: 0)
      let initialActiveExercise = exercises.object(at: initialActiveIndexPath)
      category.setActiveExercise(to: initialActiveExercise)

      // Get next active exercise, then delete initial active exercise
      let nextActiveIndexPath = IndexPath(item: 0, section: 0)
      let expected = exercises.object(at: nextActiveIndexPath)
      category.deleteExercise(from: exercises, at: initialActiveIndexPath)

      // Refresh the Exercises list, then test
      exercises = category.fetchExercises()
      let actual = category.activeExercise
      XCTAssertEqual(expected, actual)
   }

   func testNumDaysElapsed_givenVariousDates_returnsCorrectCount() {
      // Test same-day dates return zero
      var begin = DateKit.getDate(as: "2018-08-09 00:30:30")
      var end = DateKit.getDate(as: "2018-08-09 05:22:18")
      var expected = 0
      var actual = numDaysElapsed(from: begin, to: end)
      XCTAssertEqual(expected, actual)

      // Test extreme same-day dates return zero
      begin = DateKit.getDate(as: "2018-08-09 22:30:30")
      end = DateKit.getDate(as: "2018-08-09 23:59:59")
      expected = 0
      actual = numDaysElapsed(from: begin, to: end)
      XCTAssertEqual(expected, actual)

      // Test next-day dates return one
      begin = DateKit.getDate(as: "2018-08-09 03:42:16")
      end = DateKit.getDate(as: "2018-08-10 20:50:39")
      expected = 1
      actual = numDaysElapsed(from: begin, to: end)
      XCTAssertEqual(expected, actual)

      // Test extreme next-day dates return one
      begin = DateKit.getDate(as: "2018-08-09 23:59:59")
      end = DateKit.getDate(as: "2018-08-10 00:00:01")
      expected = 1
      actual = numDaysElapsed(from: begin, to: end)
      XCTAssertEqual(expected, actual)

      // Test multi-day dates return correct count
      begin = DateKit.getDate(as: "2018-08-09 11:12:13")
      end = DateKit.getDate(as: "2018-08-15 04:46:03")
      expected = 6
      actual = numDaysElapsed(from: begin, to: end)
      XCTAssertEqual(expected, actual)

      // Test extreme multi-day dates return correct count
      begin = DateKit.getDate(as: "2018-08-09 23:59:59")
      end = DateKit.getDate(as: "2018-08-19 00:00:01")
      expected = 10
      actual = numDaysElapsed(from: begin, to: end)
      XCTAssertEqual(expected, actual)

      // Test multi-month dates return correct count
      begin = DateKit.getDate(as: "2018-08-09 08:27:05")
      end = DateKit.getDate(as: "2018-09-08 03:00:33")
      expected = 30
      actual = numDaysElapsed(from: begin, to: end)
      XCTAssertEqual(expected, actual)

      // Test extreme multi-month dates return correct count
      begin = DateKit.getDate(as: "2018-08-09 23:59:59")
      end = DateKit.getDate(as: "2018-09-08 00:00:01")
      expected = 30
      actual = numDaysElapsed(from: begin, to: end)
      XCTAssertEqual(expected, actual)
   }
}
