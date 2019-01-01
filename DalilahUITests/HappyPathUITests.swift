//
//  HappyPathUITests.swift
//  HappyPathUITests
//
//  Created by Cary Miller on 10/11/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import XCTest
import Foundation

class HappyPathUITests: XCTestCase {

   /// Variables can be found in UITestBootstrap class
   let bootstrap = UITestBootstrap()

   override func setUp() {
      super.setUp()
      continueAfterFailure = false
      app.launchArguments = ["uitest", "reset"]
      app.launch()
      date = app.textFields["DateKitUI"]
      date.set("1995/1/1 00:00:00")
   }

   override func tearDown() {
      super.tearDown()
   }

   // MARK: - Happy Path Tests
   func testHappyPath1_rotatesAsExpected() {

      /*
       Click 'Add' button & check for proper initial table count
       */

      app.button("AddButton").tap()
      var count = detailTable.cells.count
      XCTAssert(count == padding)

      /*
       Add a category title & new exercises
       */

      categoryTitleTextField.tap()
      categoryTitleTextField.typeText("Manual Input Test")
      cell = detailTable.cell(0)
      cell.tap()
      cell.typeText("Manual Exercise 1")
      cell.typeReturn()
      cell = detailTable.cell(1)
      cell.tap()
      cell.typeText("Manual Exercise 2")
      cell.typeReturn()
      cell = detailTable.cell(2)
      cell.tap()
      cell.typeText("Manual Exercise 3")
      cell.typeReturn()
      cell = detailTable.cell(3)
      cell.tap()
      cell.typeText("Manual Exercise 4")
      cell.typeReturn()
      cell = detailTable.cell(4)
      cell.tap()
      cell.typeText("Manual Exercise 5")
      cell.typeReturn()
      count = detailTable.cells.count
      XCTAssert(count == padding + 5)
      detailNavbar.buttons["Back"].tap()

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cell("Manual Input Test")
      XCTAssert(cell.staticTexts["Manual Exercise 1"].exists)
      XCTAssert(cell.staticTexts["| Day 1 of 1"].exists)

      /*
       Set new date/time & check for proper display
       */

      app.launchTo("1995/1/2 00:01:00")
      exercise = cell.staticTexts["Manual Exercise 2"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/4 03:28:12")
      exercise = cell.staticTexts["Manual Exercise 4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/10 09:09:42")
      exercise = cell.staticTexts["Manual Exercise 5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/11 06:18:05")
      exercise = cell.staticTexts["Manual Exercise 1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/23 03:33:33")
      exercise = cell.staticTexts["Manual Exercise 3"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      /*
       Navigate to detail page & add new exercises
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      cell = detailTable.cell(5)
      cell.tap()
      cell.typeText("Manual Exercise 6")
      cell.typeReturn()
      cell = detailTable.cell(6)
      cell.tap()
      cell.typeText("Manual Exercise 7")
      cell.typeReturn()
      cell = detailTable.cell(7)
      cell.tap()
      cell.typeText("Manual Exercise 8")
      cell.typeReturn()
      cell = detailTable.cell(8)
      cell.tap()
      cell.typeText("Manual Exercise 9")
      cell.typeReturn()
      cell = detailTable.cell(9)
      cell.tap()
      cell.typeText("Manual Exercise 10")
      cell.typeReturn()

      count = detailTable.cells.count
      XCTAssert(count == padding + 10)
      detailNavbar.buttons["Back"].tap()

      /*
       Navigate to detail page & check for proper padded table count
       */

      masterTable.cell("Manual Input Test").tapEditButton()
      count = detailTable.cells.count
      XCTAssert(count == padding + 10)
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      cell = masterTable.cell("Manual Input Test")

      app.launchTo("1995/1/25 10:10:10")
      exercise = cell.staticTexts["Manual Exercise 5"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/30 07:07:28")
      exercise = cell.staticTexts["Manual Exercise 10"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/1/31 00:01:00")
      exercise = cell.staticTexts["Manual Exercise 1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      /*
       Navigate to detail page & add new exercises
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()

      cell = detailTable.cell(10)
      cell.tap()
      cell.typeText("Manual Exercise 11")
      cell.typeReturn()
      cell = detailTable.cell(11)
      cell.tap()
      cell.typeText("Manual Exercise 12")
      cell.typeReturn()
      cell = detailTable.cell(12)
      cell.tap()
      cell.typeText("Manual Exercise 13")
      cell.typeReturn()
      cell = detailTable.cell(13)
      cell.tap()
      cell.typeText("Manual Exercise 14")
      cell.typeReturn()
      cell = detailTable.cell(14)
      cell.tap()
      cell.typeText("Manual Exercise 15")
      cell.typeReturn()

      count = detailTable.cells.count
      XCTAssert(count == padding + 15)
      detailNavbar.buttons["Back"].tap()

      /*
       Navigate to detail screen & and reorder various cells
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()

      count = detailTable.cells.count
      let startCount = padding + 15
      XCTAssert(count == startCount)
      app.tapToolbarEditButton()

      detailTable.deleteCell(0)
      detailTable.moveCell(0, toSlot: 5)
      detailTable.moveCell(10, toSlot: 3)
      detailTable.moveCell(1, toSlot: 10)
      detailTable.deleteCell(5)
      detailTable.moveCell(12, toSlot: 8)
      detailTable.moveCell(0, toSlot: 10)
      detailTable.moveCell(10, toSlot: 5)
      detailTable.deleteCell(5)
      detailTable.deleteCell(0)
      detailTable.moveCell(3, toSlot: 0)
      detailTable.deleteCell(1)
      detailTable.deleteCell(0)

      count = detailTable.cells.count
      XCTAssert(count == startCount - 6)
      detailNavbar.navbarButton(1).tap()

      exercise = cell.staticTexts["Manual Exercise 6"]
      XCTAssert(exercise.exists)

      /*
       Set new date/time & check for proper display
       */

      app.launchTo("1995/2/4 11:52:22")
      exercise = cell.staticTexts["Manual Exercise 15"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)


      app.launchTo("1995/2/9 01:21:23")
      exercise = cell.staticTexts["Manual Exercise 6"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      /*
       Set new interval amount & type
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      app.button("Active Days").tap()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("3")
      app.typeReturn()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/2/10 00:19:40")
      exercise = cell.staticTexts["Manual Exercise 6"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/2/11 01:22:01")
      exercise = cell.staticTexts["Manual Exercise 6"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/2/11 01:22:01")
      exercise = cell.staticTexts["Manual Exercise 6"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)


      app.launchTo("1995/2/15 00:08:14")
      exercise = cell.staticTexts["Manual Exercise 7"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/2/23 08:06:31")
      exercise = cell.staticTexts["Manual Exercise 7"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/2/28 08:06:31")
      exercise = cell.staticTexts["Manual Exercise 7"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/3/1 08:00:18")
      exercise = cell.staticTexts["Manual Exercise 7"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/3/4 00:00:12")
      exercise = cell.staticTexts["Manual Exercise 7"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 3 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)


      app.launchTo("1995/3/5 11:11:19")
      exercise = cell.staticTexts["Manual Exercise 9"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)

      /*
       Navigate to detail screen & add new exercises
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()

      cell = detailTable.cell(9)
      cell.tap()
      cell.typeText("Manual Exercise 16")
      cell.typeReturn()
      cell = detailTable.cell(10)
      cell.tap()
      cell.typeText("Manual Exercise 17")
      cell.typeReturn()
      cell = detailTable.cell(11)
      cell.tap()
      cell.typeText("Manual Exercise 18")
      cell.typeReturn()
      cell = detailTable.cell(12)
      cell.tap()
      cell.typeText("Manual Exercise 19")
      cell.typeReturn()
      cell = detailTable.cell(13)
      cell.tap()
      cell.typeText("Manual Exercise 20")
      cell.typeReturn()

      count = detailTable.cells.count
      XCTAssert(count == padding + 14)

      /*
       Reorder various cells
       */

      detailTable.swipeDown()
      app.tapToolbarEditButton()
      detailTable.moveCell(10, toSlot: 3)
      detailTable.deleteCell(4)

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time
       Tap home button
       Tap app icon
       Check that expected exercise is displayed
       Repeat
       */

      cell = masterTable.cell("Manual Input Test")
      exercise = cell.staticTexts["Manual Exercise 9"]
      sleep(2)
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("1995/3/6 01:44:53")
      exercise = cell.staticTexts["Manual Exercise 17"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/3/8 18:41:56")
      exercise = cell.staticTexts["Manual Exercise 17"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/3/8 19:00:50")
      exercise = cell.staticTexts["Manual Exercise 17"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("1995/3/13 09:00:50")
      app.tapHomeButton()
      app.tapIcon()
      exercise = cell.staticTexts["Manual Exercise 15"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      /*
       Set interval amount & type
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("7")
      app.typeReturn()
      app.button("Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      app.launchTo("1995/3/20 07:07:07")
      exercise = cell.staticTexts["Manual Exercise 11"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 7"]
      XCTAssert(stats.exists)

      app.launchTo("1995/3/26 06:00:01")
      exercise = cell.staticTexts["Manual Exercise 11"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 7 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/3/31 00:18:29")
      exercise = cell.staticTexts["Manual Exercise 4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 5 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/4/3 09:38:48")
      exercise = cell.staticTexts["Manual Exercise 13"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 7"]
      XCTAssert(stats.exists)


      app.launchTo("1995/4/26 09:38:48")
      exercise = cell.staticTexts["Manual Exercise 18"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 3 of 7"]
      XCTAssert(stats.exists)

      /*
       Set interval amount & type
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("5")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      stats = cell.staticTexts["| 0 of 5 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 5 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/4/27 09:38:48")
      exercise = cell.staticTexts["Manual Exercise 18"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 5 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 5 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/4/28 05:22:20")
      exercise = cell.staticTexts["Manual Exercise 18"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 5 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/4/29 12:24:55")
      exercise = cell.staticTexts["Manual Exercise 18"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 5 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 5 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/4/30 20:28:26")
      exercise = cell.staticTexts["Manual Exercise 18"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 3 of 5 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 4 of 5 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/1 12:28:26")
      exercise = cell.staticTexts["Manual Exercise 18"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 4 of 5 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 5 of 5 completed"]
      XCTAssert(stats.exists)


      app.launchTo("1995/5/3 09:55:36")
      exercise = cell.staticTexts["Manual Exercise 19"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 5 completed"]
      XCTAssert(stats.exists)

      /*
       Set interval amount & type
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("4")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      stats = cell.staticTexts["| 0 of 4 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/4 20:28:26")
      exercise = cell.staticTexts["Manual Exercise 19"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/6 08:11:28")
      exercise = cell.staticTexts["Manual Exercise 19"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 4 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/7 06:10:09")
      exercise = cell.staticTexts["Manual Exercise 19"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 4 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/12 05:12:06")
      exercise = cell.staticTexts["Manual Exercise 19"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 3 of 4 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 4 of 4 completed"]
      XCTAssert(stats.exists)


      app.launchTo("1995/5/13 04:10:56")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 4 completed"]
      XCTAssert(stats.exists)

      /*
       Add a new exercise
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      cell = detailTable.cell(13)
      cell.tap()
      cell.typeText("Manual Exercise 21")
      cell.typeReturn()
      detailNavbar.buttons["Back"].tap()
      cell = masterTable.cell("Manual Input Test")

      stats = cell.staticTexts["| 0 of 4 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/13 08:20:32")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/14 01:20:36")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 4 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/15 08:20:32")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/15 10:10:10")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 4 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/15 10:10:20")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 3 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/15 11:11:11")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 3 of 4 completed"]
      XCTAssert(stats.exists)

      app.launchTo("1995/5/16 18:18:12")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 3 of 4 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 4 of 4 completed"]
      XCTAssert(stats.exists)


      app.launchTo("1995/5/17 05:24:54")
      exercise = cell.staticTexts["Manual Exercise 21"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 4 completed"]
      XCTAssert(stats.exists)

      /*
       Delete active exercise & check if exercise rotates
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      app.tapToolbarEditButton()
      detailTable.deleteCell(13)
      app.tapToolbarEditButton()
      detailNavbar.buttons["Back"].tap()
      exercise = cell.staticTexts["Manual Exercise 6"]
      XCTAssert(exercise.exists)

      /*
       Delete active exercise & check if exercise rotates
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      app.tapToolbarEditButton()
      detailTable.deleteCell(0)
      app.tapToolbarEditButton()
      detailNavbar.buttons["Back"].tap()
      exercise = cell.staticTexts["Manual Exercise 7"]
      XCTAssert(exercise.exists)

      /*
       Set interval amount & type
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      app.button("Days").tap()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("10")
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      stats = cell.staticTexts["| Day 1 of 10"]
      XCTAssert(stats.exists)


      app.launchTo("1995/5/27 04:20:50")
      exercise = cell.staticTexts["Manual Exercise 9"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 10"]
      XCTAssert(stats.exists)


      app.launchTo("1995/6/6 10:28:32")
      exercise = cell.staticTexts["Manual Exercise 17"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 10"]
      XCTAssert(stats.exists)

      app.launchTo("1995/6/11 09:28:32")
      exercise = cell.staticTexts["Manual Exercise 17"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 6 of 10"]
      XCTAssert(stats.exists)

      app.launchTo("1995/6/12 08:28:32")
      exercise = cell.staticTexts["Manual Exercise 17"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 7 of 10"]
      XCTAssert(stats.exists)

      app.launchTo("1995/6/13 07:28:32")
      exercise = cell.staticTexts["Manual Exercise 17"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 8 of 10"]
      XCTAssert(stats.exists)


      app.launchTo("1995/6/16 12:28:32")
      exercise = cell.staticTexts["Manual Exercise 15"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 10"]
      XCTAssert(stats.exists)

      /*
       Delete two exercises
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      app.tapToolbarEditButton()
      detailTable.deleteCell(4)
      detailTable.deleteCell(4)
      app.tapToolbarEditButton()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      app.launchTo("1995/6/26 04:20:50")
      exercise = cell.staticTexts["Manual Exercise 13"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 10"]
      XCTAssert(stats.exists)

      /*
       Clear four exercises & check for proper display
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      cell = detailTable.cell(2)
      cell.textField().clear()
      detailTable.cell(3).tap()
      cell = detailTable.cell(2)
      cell.textField().clear()
      detailTable.cell(3).tap()
      cell = detailTable.cell(3)
      cell.textField().clear()
      detailTable.cell(4).tap()
      cell = detailTable.cell(3)
      cell.textField().clear()
      detailTable.cell(4).tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Set new date/time & check for proper display
       */

      cell = masterTable.cell("Manual Input Test")
      app.launchTo("1995/7/6 03:23:41")
      exercise = cell.staticTexts["Manual Exercise 18"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 10"]
      XCTAssert(stats.exists)

      app.launchTo("1995/7/11 01:20:29")
      exercise = cell.staticTexts["Manual Exercise 18"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 6 of 10"]
      XCTAssert(stats.exists)


      app.launchTo("1995/7/16 18:16:33")
      exercise = cell.staticTexts["Manual Exercise 19"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 10"]
      XCTAssert(stats.exists)

      app.launchTo("1995/7/20 02:18:44")
      exercise = cell.staticTexts["Manual Exercise 19"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 5 of 10"]
      XCTAssert(stats.exists)


      app.launchTo("1995/7/26 08:55:28")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 10"]
      XCTAssert(stats.exists)

      app.launchTo("1995/7/29 23:59:59")
      exercise = cell.staticTexts["Manual Exercise 20"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 4 of 10"]
      XCTAssert(stats.exists)


      app.launchTo("1995/8/13 18:34:43")
      exercise = cell.staticTexts["Manual Exercise 7"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 9 of 10"]
      XCTAssert(stats.exists)

      /*
       Clear last six cells
       */

      cell = masterTable.cell("Manual Input Test")
      cell.tapEditButton()
      cell = detailTable.cell(0)
      cell.textField().clear()
      detailTable.cell(1).tap()
      cell = detailTable.cell(0)
      cell.textField().clear()
      detailTable.cell(1).tap()
      cell = detailTable.cell(0)
      cell.textField().clear()
      detailTable.cell(1).tap()
      cell = detailTable.cell(0)
      cell.textField().clear()
      detailTable.cell(1).tap()
      cell = detailTable.cell(0)
      cell.textField().clear()
      detailTable.cell(1).tap()
      cell = detailTable.cell(0)
      cell.textField().clear()
      detailTable.cell(1).tap()

      /*
       Check that correct alert displays
       */

      detailNavbar.buttons["Back"].tap()
      XCTAssert(app.alerts.element.staticTexts[
         "Would you like to save this category?"].exists
      )
   }
}
