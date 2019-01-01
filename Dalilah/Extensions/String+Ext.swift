//
//  String+Ext.swift
//  Dalilah
//
//  Created by Cary Miller on 2/22/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation

protocol OptionalString {}
extension String: OptionalString {}

extension Optional where Wrapped: OptionalString {
   var isNilOrEmpty: Bool {
      return ((self as? String) ?? "").isEmpty
   }

   var isNilOrWhitespace: Bool {
      guard let string = self as? String else {
         return true
      }
      if string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
         return true 
      } else {
         return false
      }
   }
}
