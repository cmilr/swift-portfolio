//
//  XCTest+Ext.swift
//  Dalilah
//
//  Created by Cary Miller on 2/22/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
   
   func waitForElementToAppear(
      element: XCUIElement,
      file: String = #file,
      line: UInt = #line) {

      let existsPredicate = NSPredicate(format: "exists == true")

      self.expectation(for: existsPredicate, evaluatedWith: element, handler: nil)

      waitForExpectations(timeout: 5) { error -> Void in
         if error != nil {
            let message = "Failed to find \(element) after 5 seconds."
            self.recordFailure(
               withDescription: message,
               inFile: file,
               atLine: Int(line),
               expected: true)
         }
      }
   }
}

extension XCUIElement {

   // MARK: - Cells
   func cell() -> XCUIElement {
      return self.children(matching: .cell).element(boundBy: 0)
   }

   func cell(_ int: Int) -> XCUIElement {
      return self.children(matching: .cell).element(boundBy: int).firstMatch
   }

   func cell(_ string: String) -> XCUIElement {
      return self.cells.containing(.staticText, identifier: string).firstMatch
   }

   func cellAtIndex(_ int: Int) -> XCUIElement {
      return self.children(matching: .cell).element(boundBy: int).firstMatch
   }

   func deleteCell(_ int: Int) {
      self.children(matching: .cell).element(boundBy: int).buttons["Delete "].tap()
      self.buttons["Delete"].tap()
   }

   func deleteCell(titled source: String) {
      let sourceButton = self.buttons["Delete \(source)"]
      sourceButton.tap()
      self.buttons["Delete"].tap()
   }

   func moveCell(_ source: Int, toSlot destination: Int) {
      let dest = self.children(matching: .cell).element(boundBy: destination)
      self.children(matching: .cell).element(boundBy: source).buttons["Reorder"].press(forDuration: 0.5, thenDragTo: dest)
   }

   func moveCell(titled source: String, toSlotTitled destination: String) {
      let sourceButton = self.buttons["Reorder \(source)"]
      let destinationButton = self.buttons["Reorder \(destination)"]
      sourceButton.press(forDuration: 0.5, thenDragTo: destinationButton)
   }

   // MARK: - Buttons
   func tapEditButton() {
      self.buttons["Edit"].tap()
   }

   func navbarButton(_ int: Int) -> XCUIElement {
      return self.children(matching: .button).element(boundBy: int)
   }

   func tapCheckmark() {
      return self.buttons["Checkmark Button"].tap()
   }

   func tapClearButton() {
      let button = self.buttons.element(boundBy: 0)
      self.tap()
      button.tap()
   }

   // MARK: - Text Fields
   func textField() -> XCUIElement {
      return self.textFields.element(boundBy: 0)
   }

   func textField(_ int: Int) -> XCUIElement {
      return self.textFields.element(boundBy: int)
   }

   func textField(_ string: String) -> XCUIElement {
      return self.textFields.containing(.staticText, identifier: string).firstMatch
   }

   func tapTextField() {
      self.textFields.element(boundBy: 0).tap()
   }

   // MARK: - Returns
   @objc func typeReturn() {
      self.typeText("\r")
   }

   func clear() {
      self.tap()
      guard let stringValue = self.value as? String else {
         return
      }
      var deleteString = String()
      for _ in stringValue {
         deleteString += XCUIKeyboardKey.delete.rawValue
      }
      self.typeText(deleteString)
   }
}
