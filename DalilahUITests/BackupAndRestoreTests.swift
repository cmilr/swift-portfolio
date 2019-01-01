//
//  BackupAndRestoreTests.swift
//  DalilahUITests
//
//  Created by Cary Miller on 12/17/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import XCTest
import Foundation

class BackupAndRestoreTests: XCTestCase {

   /// Variables can be found in UITestBootstrap class
   let bootstrap = UITestBootstrap()

   override func setUp() {
      super.setUp()
      continueAfterFailure = false
      app.launchArguments = ["uitest"]
      app.launch()
   }

   override func tearDown() {
      super.tearDown()
   }

   /// CAUTION: Tests start with an initial fresh install, but after that
   /// they are cumulative——treat backup counts accordingly.
   func testA_backupCount_onAbsoluteFirstLaunch_equalsOne() {
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 1
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testB_backupCount_whenUserAddsNewCategory_increases() {
      /*
       Add a new category, title, and exercises
       */

      app.button("AddButton").tap()
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
      detailNavbar.buttons["Back"].tap()

      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 2
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testC_backupCount_whenUserMovesAnExercise_increases() {
      /*
       Locate a cell and click its edit button
       */

      cell = masterTable.cell("Category 2")
      exercise = cell.staticTexts["Exercise 2.1"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 2").tapEditButton()

      /*
       Navigate to detail screen, reorder some cells,
       test for proper backup count, then navigate
       back to the master screen
       */

      app.tapToolbarEditButton()
      detailTable.moveCell(1, toSlot: 4)
      detailNavbar.buttons["Back"].tap()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      var expected = 3
      var actual = restoreTable.cells.count
      XCTAssert(expected == actual)

      restoreNavbar.buttons["Back"].tap()
      settingsNavbar.buttons["Back"].tap()

      /*
       Locate a cell and click its edit button
       */

      cell = masterTable.cell("Category 1")
      exercise = cell.staticTexts["Exercise 1.1"]
      XCTAssert(exercise.exists)
      masterTable.cell("Category 1").tapEditButton()

      /*
       Navigate to detail screen, reorder some cells,
       test for proper backup count, then navigate
       back to the master screen
       */

      app.tapToolbarEditButton()
      detailTable.moveCell(3, toSlot: 1)
      detailNavbar.buttons["Back"].tap()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      expected = 4
      actual = restoreTable.cells.count
      XCTAssert(expected == actual)

      restoreNavbar.buttons["Back"].tap()
      settingsNavbar.buttons["Back"].tap()
   }

   func testD_backupCount_whenUserDeletesAnExercise_increases() {
      /*
       Navigate to detail screen, delete some cells,
       then test for proper backup count
       */

      masterTable.cell("Category 3").tapEditButton()
      app.tapToolbarEditButton()
      detailTable.deleteCell(2)
      detailTable.deleteCell(1)
      detailNavbar.buttons["Back"].tap()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 5
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testE_backupCount_whenUserChangesIntervalType_increases() {
      /*
       Set new interval amount
       */

      masterTable.cell("Category 1").tapEditButton()
      app.button("Active Days").tap()
      detailNavbar.buttons["Back"].tap()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 6
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testF_backupCount_whenUserChangesIntervalAmount_increases() {
      /*
       Set new interval amount
       */

      masterTable.cell("Category 1").tapEditButton()
      intervalAmountTextField.tap()
      intervalAmountTextField.typeText("7")
      app.typeReturn()
      detailNavbar.buttons["Back"].tap()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 7
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testG_backupCount_whenUserChangesCategoryTitle_increases() {
      /*
       Change category title
       */

      masterTable.cell("Category 1").tapEditButton()
      categoryTitleTextField.tap()
      categoryTitleTextField.clear()
      categoryTitleTextField.typeText("New Category Title!")
      app.typeReturn()
      detailNavbar.buttons["Back"].tap()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 8
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testH_backupCount_whenUserChangesExercise_increases() {
      /*
       Change exercise title
       */

      masterTable.cell("Category 1").tapEditButton()
      cell = detailTable.cell(2)
      cell.clear()
      cell.typeText("Change Exercise Title 3")
      cell.typeReturn()
      cell = detailTable.cell(1)
      cell.clear()
      cell.typeText("Change Exercise Title 2")
      cell.typeReturn()
      cell = detailTable.cell(0)
      cell.clear()
      cell.typeText("Change Exercise Title 1")
      cell.typeReturn()
      detailNavbar.buttons["Back"].tap()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 9
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testI_backupCount_whenUserMovesACategory_increases() {
      /*
       Click the tabBar 'edit' button, then move a category
       */
      app.tapToolbarEditButton()
      masterTable.moveCell(
         titled: "Category 2, Exercise 2.1, | Day 1 of 1",
         toSlotTitled: "Category 1, Exercise 1.1, | Day 1 of 1"
      )
      app.tapToolbarEditButton()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 10
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testJ_backupCount_whenUserMovesMultipleCategories_increases() {
      /*
       Click the tabBar 'edit' button, then move some categories
       */
      app.tapToolbarEditButton()
      masterTable.moveCell(
         titled: "Category 2, Exercise 2.1, | Day 1 of 1",
         toSlotTitled: "Category 1, Exercise 1.1, | Day 1 of 1"
      )
      masterTable.moveCell(
         titled: "Category 3, Exercise 3.1, | Day 1 of 1",
         toSlotTitled: "Category 2, Exercise 2.1, | Day 1 of 1"
      )
      masterTable.moveCell(
         titled: "Category 4, Exercise 4.1, | Day 1 of 1",
         toSlotTitled: "Category 3, Exercise 3.1, | Day 1 of 1"
      )
      app.tapToolbarEditButton()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 11
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testK_backupCount_whenUserDeletesACategory_increases() {
      /*
       Click the tabBar 'edit' button, then delete a category
       */
      app.tapToolbarEditButton()
      masterTable.deleteCell(titled: "Category 4, Exercise 4.1, | Day 1 of 1")
      app.tapToolbarEditButton()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 12
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }

   func testL_backupCount_whenUserDeletesMultipleCategories_increases() {
      /*
       Click the tabBar 'edit' button, then delete some categories
       */
      app.tapToolbarEditButton()
      masterTable.deleteCell(titled: "Category 3, Exercise 3.1, | Day 1 of 1")
      masterTable.deleteCell(titled: "Category 2, Exercise 2.1, | Day 1 of 1")
      masterTable.deleteCell(titled: "Category 1, Exercise 1.1, | Day 1 of 1")
      app.tapToolbarEditButton()
      app.tapToolbarSettingsButton()
      cell = settingsTable.cell(0)
      cell.tap()
      let expected = 13
      let actual = restoreTable.cells.count
      XCTAssert(expected == actual)
   }
}
