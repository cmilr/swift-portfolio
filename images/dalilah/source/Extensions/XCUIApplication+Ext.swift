//
//  XCUIApplication+Ext.swift
//  DalilahUITests
//
//  Created by Cary Miller on 2/23/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import XCTest

extension XCUIApplication {
   func tapHomeButton() {
      XCUIDevice.shared.press(.home)
   }

   override func typeReturn() {
      self.typeText("\r")
   }

   func button(_ title: String) -> XCUIElement {
      return self.buttons[title]
   }

   func switches(_ title: String) -> XCUIElement {
      return self.switches[title]
   }

   func tapIcon() {
      if self.state == .notRunning {
         self.launchArguments = ["uitest-continue"]
         self.launch()
      } else {
         self.activate()
      }
   }

   func tapToolbarEditButton() {
      self/*@START_MENU_TOKEN@*/.toolbars["Toolbar"]/*[[".otherElements[\"DetailView\"]",".otherElements[\"DetailTableView\"].toolbars[\"Toolbar\"]",".toolbars[\"Toolbar\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.buttons["Edit"].tap()
   }

   func tapToolbarSettingsButton() {
      self/*@START_MENU_TOKEN@*/.toolbars["Toolbar"]/*[[".otherElements[\"DetailView\"]",".otherElements[\"DetailTableView\"].toolbars[\"Toolbar\"]",".toolbars[\"Toolbar\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.buttons["Settings"].tap()
   }

   // Brings upper cells back onto screen.
   func dragDown() {
      let fromCoordinate = self.coordinate(withNormalizedOffset:
         CGVector(dx: 0, dy: 10))
      let toCoordinate = self.coordinate(withNormalizedOffset:
         CGVector(dx: 0, dy: 20))
      fromCoordinate.press(forDuration: 0, thenDragTo: toCoordinate)
      sleep(2)
   }

   func shutdown() {
      XCUIDevice.shared.press(.home)
      sleep(10)
      XCUIApplication().terminate()
   }

   func launchTo(_ dateString: String) {
      var date: XCUIElement!
      date = self.textFields["DateKitUI"]
      date.set(dateString)
      self.tapHomeButton()
      self.tapIcon()
   }

   func setDateTo(_ dateString: String) {
      var date: XCUIElement!
      date = self.textFields["DateKitUI"]
      date.set(dateString)
   }
}
