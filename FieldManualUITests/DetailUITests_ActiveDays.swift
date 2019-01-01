//
//  DetailUITests_Cell1_Minutes.swift
//  DetailUITests
//
//  Created by Cary Miller on 10/11/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import XCTest
import Foundation

class DetailUITests_ActiveDays: XCTestCase {
   
   /// Variables can be found in UITestBootstrap class
   let bootstrap = UITestBootstrap()

   override func setUp() {
      super.setUp()
      continueAfterFailure = false
      app.launchArguments = ["uitest", "reset"]
      app.launch()
      date = app.textFields["DateKitUI"]
      date.set("2000/1/1 00:00:00")
   }

   override func tearDown() {
      super.tearDown()
   }

   // MARK: - Detail Screen Integrity Tests
   func testExercises_deletedAndReordered_rotateCorrectly() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cell("Category 2")
      exercise = cell.staticTexts["Exercise 2.1"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 2").tapEditButton()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Navigate to detail screen & delete/reorder various cells
       */

      masterTable.cell("Category 2").tapEditButton()
      var count = detailTable.cells.count
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

      /*
       Set new date/time & check for proper display
       */

      exercise = cell.staticTexts["Exercise 2.6"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/2 02:00:10")
      exercise = cell.staticTexts["Exercise 2.7"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/3 01:02:00")
      exercise = cell.staticTexts["Exercise 2.9"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/4 10:03:33")
      exercise = cell.staticTexts["Exercise 2.10"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/5 04:04:40")
      exercise = cell.staticTexts["Exercise 2.15"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/6 01:05:00")
      exercise = cell.staticTexts["Exercise 2.11"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/7 08:06:34")
      exercise = cell.staticTexts["Exercise 2.4"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/8 01:07:00")
      exercise = cell.staticTexts["Exercise 2.13"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/9 00:08:26")
      exercise = cell.staticTexts["Exercise 2.14"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 1 completed"]
      XCTAssert(stats.exists)


      app.launchTo("2000/1/10 01:09:12")
      exercise = cell.staticTexts["Exercise 2.6"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 1 completed"]
      XCTAssert(stats.exists)
   }

   func testExercises_whenAddingEntries_padsCorrectly() {

      /*
       Click 'Add' button & check for correct table count
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
      count = detailTable.cells.count
      XCTAssert(count == padding + 3)
      detailNavbar.buttons["Back"].tap()

      /*
       Check for proper display & padded table count
       */

      cell = masterTable.cell("Manual Input Test")
      exercise = cell.staticTexts["Manual Exercise 1"]
      XCTAssert(exercise.exists)
      masterTable.cell("Manual Input Test").tapEditButton()
      count = detailTable.cells.count
      XCTAssert(count == padding + 3)

      /*
       Add a category title & new exercises
       */

      cell = detailTable.cell(3)
      cell.tap()
      cell.typeText("Manual Exercise 4")
      cell.typeReturn()
      cell = detailTable.cell(4)
      cell.tap()
      cell.typeText("Manual Exercise 5")
      cell.typeReturn()
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
       Check for proper padded table count
       */

      masterTable.cell("Manual Input Test").tapEditButton()
      count = detailTable.cells.count
      XCTAssert(count == padding + 10)

      /*
       Check that proper padded table count hasn't changed
       */

      detailNavbar.buttons["Back"].tap()
      masterTable.cell("Manual Input Test").tapEditButton()
      count = detailTable.cells.count
      XCTAssert(count == padding + 10)

      /*
       Delete five entries & check padded table count
       */

      app.tapToolbarEditButton()
      detailTable.deleteCell(4)
      detailTable.deleteCell(3)
      detailTable.deleteCell(2)
      detailTable.deleteCell(1)
      detailTable.deleteCell(0)
      count = detailTable.cells.count
      XCTAssert(count == padding + 5)
      detailNavbar.buttons["Back"].tap()
      masterTable.cell("Manual Input Test").tapEditButton()
      count = detailTable.cells.count
      XCTAssert(count == padding + 5)
   }

   func testExercises_clickingCategoryTitleThenClickingBack_doesntCrash() {

      /*
       Click 'Add' button, click category title, then click back
       */

      app.button("AddButton").tap()
      categoryTitleTextField.tap()
      detailNavbar.buttons["Back"].tap()
      let count = masterTable.cells.count
      XCTAssert(count == 4)
   }

   func testExercises_activeExerciseCleared_rotatesCorrectly() {

      /*
       Locate first cell & check for proper display
       */

      let masterCell = masterTable.cell("Category 2")
      exercise = masterCell.staticTexts["Exercise 2.1"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 2").tapEditButton()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()

      /*
       Navigate to detail screen & clear active exercise cell
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 2.1"]
      XCTAssert(!exercise.exists)
      detailNavbar.buttons["Back"].tap()

      exercise = masterCell.staticTexts["Exercise 2.2"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 2").tapEditButton()

      /*
       Navigate to detail screen & clear active exercise cell
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      
      exercise = cell.staticTexts["Exercise 2.2"]
      XCTAssert(!exercise.exists)
      detailNavbar.buttons["Back"].tap()

      exercise = masterCell.staticTexts["Exercise 2.3"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 2").tapEditButton()

      /*
       Navigate to detail screen & clear active exercise cell
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 2.3"]
      XCTAssert(!exercise.exists)
      detailNavbar.buttons["Back"].tap()

      exercise = masterCell.staticTexts["Exercise 2.4"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 2").tapEditButton()

      /*
       Navigate to detail screen & clear active exercise cell
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 2.4"]
      XCTAssert(!exercise.exists)
      detailNavbar.buttons["Back"].tap()

      exercise = masterCell.staticTexts["Exercise 2.5"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 2").tapEditButton()
   }

   func testExercises_activeExercisesClearedAtOnce_rotateCorrectly() {

      /*
       Locate first cell & check for proper display
       */

      let masterCell = masterTable.cell("Category 3")
      exercise = masterCell.staticTexts["Exercise 3.1"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 3").tapEditButton()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.1"]
      XCTAssert(!exercise.exists)
      detailTable.cell(1).tap()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.2"]
      XCTAssert(!exercise.exists)
      detailTable.cell(1).tap()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.3"]
      XCTAssert(!exercise.exists)
      cell.textField().typeReturn()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.4"]
      XCTAssert(!exercise.exists)
      detailTable.cell(1).tap()
      detailNavbar.buttons["Back"].tap()

      exercise = masterCell.staticTexts["Exercise 3.5"]
      XCTAssert(exercise.exists)
   }

   func testExercises_activeExercisesClearedAtOnce_displaysAlert() {

      /*
       Locate first cell & check for proper display
       */

      let masterCell = masterTable.cell("Category 3")
      exercise = masterCell.staticTexts["Exercise 3.1"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 3").tapEditButton()

      /*
       Set interval amount & type
       */

      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("1")
      app.typeReturn()
      app.button("Active Days").tap()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.1"]
      XCTAssert(!exercise.exists)
      cell.textField().typeReturn()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.2"]
      XCTAssert(!exercise.exists)
      cell.textField().typeReturn()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.3"]
      XCTAssert(!exercise.exists)
      cell.textField().typeReturn()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.4"]
      XCTAssert(!exercise.exists)
      cell.textField().typeReturn()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()
      exercise = cell.staticTexts["Exercise 3.5"]
      XCTAssert(!exercise.exists)

      /*
       Clear final exercise cell & verify correct alert displays
       */

      detailNavbar.buttons["Back"].tap()
      XCTAssert(app.alerts.element.staticTexts[
         "Would you like to save this category?"].exists
      )
   }

   func testExercises_exercisesClearedRandomly_doesntCrash_displaysAlert() {

      /*
       Locate first cell & check for proper display
       */

      let masterCell = masterTable.cell("Category 2")
      exercise = masterCell.staticTexts["Exercise 2.1"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 2").tapEditButton()

      /*
       Clear active exercise cell & verify proper display
       */

      cell = detailTable.cell(0)
      cell.textField().clear()

      cell = detailTable.cell(3)
      cell.tapTextField()

      cell = detailTable.cell(1)
      cell.tapTextField()

      cell = detailTable.cell(2)
      cell.tapTextField()

      cell = detailTable.cell(3)
      cell.tapTextField()

      cell = detailTable.cell(2)
      cell.tapTextField()

      cell = detailTable.cell(1)
      cell.tapTextField()

      cell = detailTable.cell(0)
      cell.tapTextField()

      cell = detailTable.cell(3)
      cell.textField().clear()

      cell = detailTable.cell(5)
      cell.tapTextField()

      cell = detailTable.cell(7)
      cell.tapTextField()

      cell = detailTable.cell(5)
      cell.tapTextField()

      cell = detailTable.cell(7)
      cell.textField().clear()

      cell = detailTable.cell(6)
      cell.textField().clear()

      cell = detailTable.cell(5)
      cell.textField().clear()

      cell = detailTable.cell(0)
      cell.tapTextField()

      cell = detailTable.cell(1)
      cell.tapTextField()

      cell = detailTable.cell(2)
      cell.tapTextField()

      cell = detailTable.cell(3)
      cell.tapTextField()

      cell = detailTable.cell(4)
      cell.tapTextField()

      cell = detailTable.cell(5)
      cell.tapTextField()

      cell = detailTable.cell(5)
      cell.textField().clear()

      cell = detailTable.cell(4)
      cell.textField().clear()

      cell = detailTable.cell(6)
      cell.tapTextField()
      cell = detailTable.cell(5)
      cell.textField().clear()

      cell = detailTable.cell(6)
      cell.tapTextField()
      cell = detailTable.cell(5)
      cell.textField().clear()

      cell = detailTable.cell(0)
      cell.textField().clear()

      cell = detailTable.cell(1)
      cell.tapTextField()
      cell = detailTable.cell(0)
      cell.textField().clear()

      cell = detailTable.cell(4)
      cell.tapTextField()
      cell = detailTable.cell(3)
      cell.textField().clear()

      cell = detailTable.cell(2)
      cell.tapTextField()

      cell = detailTable.cell(1)
      cell.tapTextField()

      cell = detailTable.cell(2)
      cell.tapTextField()

      cell = detailTable.cell(0)
      cell.tapTextField()
      cell = detailTable.cell(0)
      cell.textField().clear()

      cell = detailTable.cell(2)
      cell.tapTextField()
      cell = detailTable.cell(1)
      cell.textField().clear()

      cell = detailTable.cell(0)
      cell.tapTextField()
      cell = detailTable.cell(0)
      cell.textField().clear()

      /*
       Clear final exercise cell & verify correct alert displays
       */

      detailNavbar.buttons["Back"].tap()
      XCTAssert(app.alerts.element.staticTexts[
         "Would you like to save this category?"].exists
      )
   }

   func testExercise_setTo1Day_completedThenSetToActiveDays_returnsStatToZero() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()

      /*
       Set new interval amount & type
       */

      masterTable.cell("Category 1").tapEditButton()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("3")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Return to master screen & check that 'completed' stat has gone back to zero
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 3 completed"]
      XCTAssert(stats.exists)
   }

   func testExercise_setTo7Days_intervalReduced_returnsProperStats() {

      /*
       Locate first cell & check for proper display
       */

      cell = masterTable.cells.element(boundBy: 0).firstMatch
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| Day 1 of 1"]
      XCTAssert(stats.exists)

      /*
       Set new interval amount & type
       */

      masterTable.cell("Category 1").tapEditButton()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("7")
      app.typeReturn()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()

      /*
       Return to master screen & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 0 of 7 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 1 of 7 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/2 12:45:08")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 1 of 7 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 2 of 7 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/3 08:21:34")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 2 of 7 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 3 of 7 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/8 02:18:54")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 3 of 7 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 4 of 7 completed"]
      XCTAssert(stats.exists)

      app.launchTo("2000/1/14 22:25:03")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 4 of 7 completed"]
      XCTAssert(stats.exists)

      cell.tapCheckmark()
      stats = cell.staticTexts["| 5 of 7 completed"]
      XCTAssert(stats.exists)

      /*
       Set new interval amount
       */

      masterTable.cell("Category 1").tapEditButton()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("6")
      app.typeReturn()
      detailNavbar.buttons["Back"].tap()

      /*
       Return to master screen & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 5 of 6 completed"]
      XCTAssert(stats.exists)

      /*
       Set new interval amount
       */

      masterTable.cell("Category 1").tapEditButton()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("3")
      app.typeReturn()
      detailNavbar.buttons["Back"].tap()

      /*
       Return to master screen & check for proper display
       */

      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      stats = cell.staticTexts["| 3 of 3 completed"]
      XCTAssert(stats.exists)
   }
}
