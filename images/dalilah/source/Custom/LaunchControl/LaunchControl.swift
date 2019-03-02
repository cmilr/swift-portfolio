//
//  LaunchControl.swift
//
//  Created by Cary Miller on 12/13/18.
//  Copyright © 2018 Cary Miller.
//

import Foundation

extension UserDefaults {
   enum Keys : String {
      case absoluteFirstLaunch
      case newVersionFirstLaunch
      case lastVersionNumber
   }
}

class LaunchControl {

   let defaults = UserDefaults.standard

   var isAbsoluteFirstLaunch: Bool {
      get {
         return self.defaults.object(
            forKey: UserDefaults.Keys.absoluteFirstLaunch.rawValue) as! Bool
      }
   }

   var isNewVersionFirstLaunch: Bool {
      get {
         return self.defaults.object(
            forKey: UserDefaults.Keys.newVersionFirstLaunch.rawValue) as! Bool
      }
   }

   init() {
      updateFirstLaunchStatus()
   }

   public func updateFirstLaunchStatus() {
      calculateAbsoluteFirstLaunchStatus()
      calculateNewVersionFirstLaunchStatus()
   }

   private func calculateAbsoluteFirstLaunchStatus() {
      if defaults.object(forKey: UserDefaults.Keys.absoluteFirstLaunch.rawValue) == nil {
         defaults.set(true, forKey: UserDefaults.Keys.absoluteFirstLaunch.rawValue)
      } else {
         defaults.set(false, forKey: UserDefaults.Keys.absoluteFirstLaunch.rawValue)
      }
   }

   private func calculateNewVersionFirstLaunchStatus() {
      let currentInstalledVersion = Bundle.main.object(
         forInfoDictionaryKey: "CFBundleShortVersionString") as! String

      let lastInstalledVersion: String
      if defaults.object(forKey: UserDefaults.Keys.lastVersionNumber.rawValue) == nil {
         lastInstalledVersion = "nil"
      } else {
         lastInstalledVersion = defaults.object(
            forKey: UserDefaults.Keys.lastVersionNumber.rawValue) as! String
      }

      if currentInstalledVersion == lastInstalledVersion {
         defaults.set(false, forKey: UserDefaults.Keys.newVersionFirstLaunch.rawValue)
      } else {
         defaults.set(true, forKey: UserDefaults.Keys.newVersionFirstLaunch.rawValue)
      }
      defaults.set(currentInstalledVersion, forKey: UserDefaults.Keys.lastVersionNumber.rawValue)
   }
}
