//
//  DalilahScreenshots.swift
//  DalilahScreenshots
//
//  Created by Cary Miller on 1/6/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//
//  swiftlint:disable colon
import XCTest

class DalilahScreenshots: XCTestCase {

   override func setUp() {
      super.setUp()
      let app = XCUIApplication()
      app.launchArguments = ["screenshots"]
      setupSnapshot(app)
      app.launch()
   }

   override func tearDown() {
      super.tearDown()
   }

   func testAutomateScreenshots() {
      let app = XCUIApplication()
      let tablesQuery = app.tables

      snapshot("01MasterScreen")

      tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Set List")/*[[".cells.containing(.staticText, identifier:\"Our Last Goodbye\")",".cells.containing(.staticText, identifier:\"Songs\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Edit"].tap()

      snapshot("02DetailScreen")
   }

}
