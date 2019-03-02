//
//  TimeInterval+Ext.swift
//  Dalilah
//
//  Created by Cary Miller on 6/29/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation

extension TimeInterval {
   private var milliseconds: Float {
      return Float((truncatingRemainder(dividingBy: 1)) * -1000)
   }

   private var seconds: Int {
      return Int(self) % 60
   }

   private var minutes: Int {
      return (Int(self) / 60 ) % 60
   }

   private var hours: Int {
      return Int(self) / 3600
   }

   var stringTime: String {
      if seconds != 0 && milliseconds != 0 {
         return "\nFinished in \(abs(seconds))s & \(milliseconds)ms"
      } else if milliseconds != 0 {
         return "\nFinished in \(milliseconds)ms"
      } else {
         return "\(abs(seconds))s"
      }
   }
}
