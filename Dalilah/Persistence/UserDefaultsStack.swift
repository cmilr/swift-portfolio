//
//  UserDefaultsStack.swift
//  Dalilah
//
//  Created by Cary Miller on 1/10/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation

class UserDefaultsStack {
   let defaults = UserDefaults.standard
   let testDataKey = "testDataKey"
   let mockDateKey = "mockDateKey"

   func saveMockedDate() {
      let mockDate = DateKit.now()
      defaults.set(mockDate, forKey: mockDateKey)
   }

   func getMockedDate() -> Date {
      if let result = defaults.object(forKey: mockDateKey) as? Date {
         return result
      }
      fatalError("Undefined State: could not retrieve mock date from UserDefaults.")
   }
}
