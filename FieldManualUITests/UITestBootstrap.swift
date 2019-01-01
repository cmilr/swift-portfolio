//
//  UITestBootstrap.swift
//  FieldManualUITests
//
//  Created by Cary Miller on 12/19/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import XCTest

let app = XCUIApplication()
var date: XCUIElement!
var masterNavbar: XCUIElement!
var masterTable: XCUIElement!
var detailNavbar: XCUIElement!
var detailTable: XCUIElement!
var settingsNavbar: XCUIElement!
var settingsTable: XCUIElement!
var restoreNavbar: XCUIElement!
var restoreTable: XCUIElement!
var categoryTitleTextField: XCUIElement!
var intervalAmountTextField: XCUIElement!
var cell: XCUIElement!
var exercise: XCUIElement!
var stats: XCUIElement!
let padding = 50

class UITestBootstrap {

   init() {
      configureVariables()
   }

   // -NavigationBars-
   // The "MasterView" in app.navigationBars["FieldManual.MasterView"] ==
   // Storyboard.MasterScene.Master.View.AccessibilityLabel

   // -Tables-
   // The "MasterTableView" in app.tables["MasterTableView"] ==
   // Storyboard.MasterScene.Master.View.TableView.AccessibilityLabel

   func configureVariables() {
      masterNavbar = app.navigationBars["FieldManual.MasterView"]
      masterTable = app.tables["MasterTableView"]

      detailNavbar = app.navigationBars["FieldManual.DetailView"]
      detailTable = app.tables["DetailTableView"]

      settingsNavbar = app.navigationBars["FieldManual.SettingsTableView"]
      settingsTable = app.tables["SettingsTableView"]

      restoreNavbar = app.navigationBars["FieldManual.RestoreView"]
      restoreTable = app.tables["RestoreTableView"]

      categoryTitleTextField = app.textFields["DetailCategoryTitleField"]
      intervalAmountTextField = app.textFields["IntervalAmountField"]
   }
}
