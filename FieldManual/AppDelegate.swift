//
//  AppDelegate.swift
//  FieldManual
//
//  Created by Cary Miller on 10/11/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var coreData = CoreDataStack(modelName: "FieldManualA")
   var userDefaults = UserDefaultsStack()
   var launchControl = LaunchControl()
   var coreLogic: CoreLogic! = nil
   var coreRestore: CoreRestore! = nil
   var audioClip: AudioClip! = nil
   var window: UIWindow?

   // Runs whenever app is fully launched, but not on relaunch.
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      configureLaunchOptions()
      _ = Services(coreDataStack: coreData, userDefaultsStack: userDefaults)
      let initialController = window?.rootViewController as! UINavigationController
      let masterController = initialController.viewControllers.first as! MasterViewController
      coreLogic = CoreLogic(coreDataStack: coreData, userDefaultsStack: userDefaults)
      coreRestore = CoreRestore(modelName: coreData.modelName, container: coreData.container)
      audioClip = AudioClip()
      masterController.coreLogic = coreLogic
      masterController.categories = coreLogic.categories
      masterController.coreRestore = coreRestore
      masterController.audioClip = audioClip
      self.coreLogic.calculateIntervalsAndDates()
      if launchControl.isAbsoluteFirstLaunch { coreRestore.backup() }

      #if DEBUG
      let documentsDirectory = FileManager.default.urls(
         for: .documentDirectory,
         in: .userDomainMask
         )[0].path
      print(documentsDirectory)
      #endif

      return true
   }

   // Runs whenever app is relaunched, but not on initial launch.
   func applicationWillEnterForeground(_ application: UIApplication) {
      launchControl.updateFirstLaunchStatus()
      coreLogic.calculateIntervalsAndDates()
   }

   // Runs whenever app comes out of a background state; also when the user
   // ignores an interruption such as incoming phone calls and SMS messages.
   func applicationDidBecomeActive(_ application: UIApplication) {
   }

   // Runs whenever app *begins* to enter a background state, including
   // when the device receives an incoming call, SMS message, etc.
   // * Good place to pause tasks, disable timers, etc.
   func applicationWillResignActive(_ application: UIApplication) {
      coreData.save()
      if uiTest { userDefaults.saveMockedDate() }
   }

   // Runs whenever app enters the background state, whether by user pressing
   // the 'Home' button, acceptance of an incoming call or SMS message, or some
   // other action. Gives you five seconds to perform tasks or to request
   // additional time by calling beginBackgroundTask(expirationHandler:)
   // * Good place to save user data & app state, disable UI, etc.
   func applicationDidEnterBackground(_ application: UIApplication) {
      coreData.save()
   }

   // Lets your app know that it's about to be terminated and purged from memory
   // entirely. Gives you five seconds to perform any tasks; if not returned
   // before then, the system may kill the process altogether.
   // * Good place to for final clean-up, such as freeing resources, saving data.
   func applicationWillTerminate(_ application: UIApplication) {
      coreData.save()
   }

   func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
      coreData.save()
   }
}

extension AppDelegate {

   private func configureLaunchOptions() {
      if ProcessInfo.processInfo.arguments.contains("uitest") {
         uiTest = true
      }
      if ProcessInfo.processInfo.arguments.contains("uitest-continue") {
         uiTestContinue = true
      }
      if ProcessInfo.processInfo.arguments.contains("screenshots") {
         screenshots = true
      }
      #if SIMULATOR
         simulator = true
      #endif
   }
}
