//
//  MasterUITests_Cell0_Weeks.swift
//  DalilahUITests
//
//  Created by Cary Miller on 4/4/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import XCTest

class MasterUITests_Days: XCTestCase {

   /// Variables can be found in UITestBootstrap class
   let bootstrap = UITestBootstrap()

   override func setUp() {
      super.setUp()
      continueAfterFailure = false
      app.launchArguments = ["uitest", "reset"]
      app.launch()
      date = app.textFields["DateKitUI"]
      date.set("1995/1/1 10:00:00")
   }

   override func tearDown() {
      super.tearDown()
   }

   func testExercise_setTo1Day_givenVariousDays_doesOrDoesntRotate() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      /*
       Set new date/time & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      // Random click to detail page
      cell = masterTable.cells.element(boundBy: 0).firstMatch
      cell.buttons["Edit"].tap()
      detailNavbar.buttons["Back"].tap()


      app.launchTo("1995/1/2 18:36:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/3 03:03:21")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/4 23:02:00")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/10 20:03:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/11 00:04:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/23 02:05:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo1Day_givenVariousDaysAndCompleted_doesOrDoesntRotate() {

      /*
       Set new date/time & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      /*
       Set new date/time & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()


      app.launchTo("1995/1/2 18:01:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()

      app.launchTo("1995/1/2 19:33:12")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/4 02:02:00")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()


      app.launchTo("1995/1/10 08:03:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()

      app.launchTo("1995/1/10 23:42:28")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/11 00:04:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()


      app.launchTo("1995/1/23 22:05:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo3Days_givenVariousDays_doesOrDoesntRotate() {

      /*
       Set new date/time & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("3")
      app.typeReturn()
      app.button("Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/4 00:01:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 3"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/5 00:01:20")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 3"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/6 20:08:23")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/10 08:03:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 3"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/12 02:33:13")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/21 00:03:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 3"]
      XCTAssert(stats.exists)
      

      app.launchTo("1995/1/22 00:04:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/2/4 00:04:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 3"]
      XCTAssert(stats.exists)

      app.launchTo("1995/2/5 00:05:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/2/6 00:09:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 3"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo3Days_givenClicksToDetailPage_doesOrDoesntRotate() {

      /*
       Set new date/time & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("3")
      app.typeReturn()
      app.button("Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/4 00:01:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 3"]
      XCTAssert(stats.exists)

      // Random click to detail page
      cell = masterTable.cells.element(boundBy: 0).firstMatch
      cell.buttons["Edit"].tap()
      detailNavbar.buttons["Back"].tap()

      app.launchTo("1995/1/5 00:01:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/10 00:02:08")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 3"]
      XCTAssert(stats.exists)

      // Random click to detail page
      cell = masterTable.cells.element(boundBy: 0).firstMatch
      cell.buttons["Edit"].tap()
      detailNavbar.buttons["Back"].tap()

      app.launchTo("1995/1/20 00:01:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/23 00:00:24")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/2/4 00:00:19")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 3"]
      XCTAssert(stats.exists)

      // Random click to detail page
      cell = masterTable.cells.element(boundBy: 0).firstMatch
      cell.buttons["Edit"].tap()
      detailNavbar.buttons["Back"].tap()

      app.launchTo("1995/2/5 00:11:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 3"]
      XCTAssert(stats.exists)


      app.launchTo("1995/2/7 00:01:06")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 3"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo7Days_givenVariousDays_doesOrDoesntRotate() {

      /*
       Set new date/time & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("7")
      app.typeReturn()
      app.button("Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 7"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/4 00:08:53")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 4 of 7"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/7 00:01:01")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 7 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/10 08:33:44")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 7"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/12 19:18:02")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 5 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/17 00:01:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 7"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/21 03:42:35")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 7 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/31 06:44:44")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 7"]
      XCTAssert(stats.exists)
      

      app.launchTo("1995/2/26 10:01:10")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 7"]
      XCTAssert(stats.exists)

      app.launchTo("1995/3/4 03:33:09")
      exercise = cell.staticTexts["Exercise 1.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 7 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/3/5 05:34:02")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 7"]
      XCTAssert(stats.exists)

      app.launchTo("1995/3/6 02:02:22")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 7"]
      XCTAssert(stats.exists)

      app.launchTo("1995/3/11 09:55:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 7 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/3/17 04:04:55")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 6 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/3/20 07:34:12")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 2 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/4/28 08:10:10")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 6 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/6/28 00:01:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 4 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/7/2 09:09:09")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 7"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo21Days_givenVariousDays_doesntOrDoesntRotate() {

      /*
       Set new date/time & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)
      cell.buttons["Edit"].tap()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("21")
      app.typeReturn()
      app.button("Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 21"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/4 04:01:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 4 of 21"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/7 05:01:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 7 of 21"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/22 06:01:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 21"]
      XCTAssert(stats.exists)

      app.launchTo("1995/1/25 07:01:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 4 of 21"]
      XCTAssert(stats.exists)


      app.launchTo("1995/2/21 08:01:00")
      exercise = cell.staticTexts["Exercise 1.3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 10 of 21"]
      XCTAssert(stats.exists)


      app.launchTo("1995/4/5 09:01:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 11 of 21"]
      XCTAssert(stats.exists)

      app.launchTo("1995/4/9 10:01:00")
      exercise = cell.staticTexts["Exercise 1.5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 15 of 21"]
      XCTAssert(stats.exists)


      app.launchTo("1995/4/21 11:01:00")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 6 of 21"]
      XCTAssert(stats.exists)


      app.launchTo("1995/8/27 12:01:00")
      exercise = cell.staticTexts["Exercise 1.2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 8 of 21"]
      XCTAssert(stats.exists)
   }
}
