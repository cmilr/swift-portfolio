//
//  Recording.swift
//  FieldManualUITests
//
//  Created by Cary Miller on 5/11/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import XCTest

class Recording: XCTestCase {
        
   let app = XCUIApplication()
   var date: XCUIElement!
   var masterNavbar: XCUIElement!
   var detailNavbar: XCUIElement!
   var masterTable: XCUIElement!
   var detailTable: XCUIElement!
   var intervalAmountTextField: XCUIElement!
   var cell: XCUIElement!
   var exercise: XCUIElement!

   override func setUp() {
      super.setUp()
      continueAfterFailure = false
      app.launchArguments = ["uitest", "reset"]
      app.launch()
      date = app.textFields["DateKitUI"]
      date.set("2000/1/1 0:0:0")
      configure()
   }

   override func tearDown() {
      super.tearDown()
   }

   func configure() {
      masterNavbar = app.navigationBars["FieldManual.MasterView"]
      detailNavbar = app.navigationBars["FieldManual.DetailView"]
      masterTable = app.tables["MasterTableView"]
      detailTable = app.tables["DetailTableView"]
      intervalAmountTextField = app.textFields["IntervalAmountField"]
   }

   func testRecord() {



      let app = XCUIApplication()
      app.toolbars["Toolbar"].buttons["Edit"].tap()

      let mastertableviewTable = app.tables["MasterTableView"]
      mastertableviewTable/*@START_MENU_TOKEN@*/.buttons["Reorder Blue Moon of Kentucky, Set List"]/*[[".cells.buttons[\"Reorder Blue Moon of Kentucky, Set List\"]",".buttons[\"Reorder Blue Moon of Kentucky, Set List\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()

      let reorderScalePracticeGMajorButton = mastertableviewTable/*@START_MENU_TOKEN@*/.buttons["Reorder Scale Practice, G Major"]/*[[".cells.buttons[\"Reorder Scale Practice, G Major\"]",".buttons[\"Reorder Scale Practice, G Major\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      reorderScalePracticeGMajorButton/*@START_MENU_TOKEN@*/.press(forDuration: 0.7);/*[[".tap()",".press(forDuration: 0.7);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      reorderScalePracticeGMajorButton.swipeUp()

   }
}
