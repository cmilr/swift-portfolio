//
//  AudioClip.swift
//  FieldManual
//
//  Created by Cary Miller on 11/29/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import AVFoundation

class AudioClip {
   
   var sessionComplete: AVAudioPlayer!
   var sessionCompleteD: AVAudioPlayer!
   var nextCategory: AVAudioPlayer!
   var editCell: AVAudioPlayer!
   var editTableView: AVAudioPlayer!
   var editTableViewD: AVAudioPlayer!
   var showSettings: AVAudioPlayer!
   var addCategory: AVAudioPlayer!
   var goBack: AVAudioPlayer!
   var setInterval: AVAudioPlayer!
   var alert: AVAudioPlayer!

   init() {
      sessionComplete = configure(
         title: "Click - Tap_Done_Checkbox5.caf",
         vol: 0.8)

      sessionCompleteD = configure(
         title: "Click - Tap_Done_Checkbox4.caf",
         vol: 0.2)

      nextCategory = configure(
         title: "Click - Tap_Done_Checkbox1_short.caf",
         vol: 0.4)

      editCell = configure(
         title: "Click - Tap_Done_Checkbox6.caf",
         vol: 1.0)

      editTableView = configure(
         title: "Click - Tap_Done_Checkbox6.caf",
         vol: 1.0)

      editTableViewD = configure(
         title: "Click - Tap_Done_Checkbox1.caf",
         vol: 0.6)

      showSettings = configure(
         title: "Click - Tap_Done_Checkbox6.caf",
         vol: 1.0)

      addCategory = configure(
         title: "Tiny - Done_PopUp1_1.caf",
         vol: 0.3)

      goBack = configure(
         title: "Click - Tap_Done_Checkbox1.caf",
         vol: 0.6)

      setInterval = configure(
         title: "DoubleClick - Done_Checkbox1_1.caf",
         vol: 0.6)

      alert = configure(
         title: "Dot - Retry.caf",
         vol: 0.5)
   }
   
   private func configure(title: String, vol: Float) -> AVAudioPlayer? {
      let path = Bundle.main.path(forResource: title, ofType: nil)!
      let url = URL(fileURLWithPath: path)
      do {
         let player = try AVAudioPlayer(contentsOf: url)
         player.volume = vol
         player.prepareToPlay()
         return player
      } catch let error {
         print("Error: \(error)")
         return nil
      }
   }
}

extension AVAudioPlayer {
   func playSound() {
      self.stop()
      self.currentTime = 0
      self.play()
   }
}
