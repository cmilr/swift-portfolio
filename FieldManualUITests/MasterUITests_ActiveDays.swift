//
//  MasterUITests_ActiveDays.swift
//  FieldManualUITests
//
//  Created by Cary Miller on 4/6/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import XCTest
import Foundation

class MasterUITests_ActiveDays: XCTestCase {

   /// Variables can be found in UITestBootstrap class
   let bootstrap = UITestBootstrap()

   override func setUp() {
      super.setUp()
      continueAfterFailure = false
      app.launchArguments = ["uitest", "reset"]
      app.launch()
      date = app.textFields["DateKitUI"]
      date.set("2000/1/1 0:0:0")
   }

   override func tearDown() {
      super.tearDown()
   }

   // MARK: - 1 Day Interval Tests
   func testExercise_setTo1Day_given23HoursAndCompleted_doesntRotate() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/1 22:45:08")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/2 03:22:54")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/2 23:00:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/2 23:31:18")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/3 00:00:10")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/3 23:59:59")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/4 03:00:01")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/4 19:19:19")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/5 01:35:18")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/5 23:58:57")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/6 00:00:01")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/6 19:56:08")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/7 21:32:53")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo1Day_givenSameDayAndCompleted_doesntRotate() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      app.launchTo("2000/1/2 00:00:10")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/2 01:02:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/3 00:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/3 18:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/3 19:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/3 23:59:59")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/4 09:00:10")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo1Day_given1DayAndCompleted_rotates() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/2 18:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/3 04:00:10")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/4 03:00:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/5 23:00:10")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/6 08:00:10")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo1Day_given1DayAndCompletedThenDecompleted_doesntRotate() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/2 00:00:10")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/2 00:00:11")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/3 00:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/3 20:00:22")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/4 00:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/5 23:38:11")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]

      XCTAssert(stats.exists)
      cell.tapCheckmark()
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/6 09:38:11")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/7 02:02:02")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo1Day_givenVariousDaysNotCompleted_doesntRotate() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      app.launchTo("2000/1/2 00:00:10")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/3 00:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/4 00:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/5 00:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/6 00:00:10")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/7 00:00:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/8 00:00:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/9 00:00:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/10 00:00:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/11 00:00:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/12 00:00:10")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/13 00:00:10")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/14 00:00:10")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo1Day_given2DaysAndCompleted_rotates() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/3 00:00:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/5 00:00:10")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/7 00:00:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/9 00:00:10")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/11 00:00:10")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)
   }

   // MARK: - 3 Day Interval Tests
   func testExercise_setTo3Days_given2DaysNotCompleted_doesntRotate_given3DaysCompleted_rotates() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("3")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      app.launchTo("2000/1/2 08:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/3 23:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/4 19:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/5 01:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/5 12:59:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/6 22:00:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/7 02:00:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/7 03:00:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/8 18:00:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/9 20:00:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/10 12:00:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/10 10:59:09")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/11 23:00:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/12 23:00:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/13 23:00:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/14 23:00:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/15 23:00:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/16 23:00:00")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/17 23:00:00")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/18 23:00:00")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/19 23:00:00")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/20 23:00:00")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/21 23:00:00")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/22 23:00:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/23 23:00:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/24 23:00:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/25 23:00:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/26 23:00:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/27 23:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/28 23:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/29 23:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/30 23:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/31 23:00:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/2/1 23:00:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)
   }
}
