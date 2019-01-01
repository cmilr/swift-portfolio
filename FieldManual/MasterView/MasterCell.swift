//
//  MasterCell.swift
//  FieldManual
//
//  Created by Cary Miller on 10/12/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit

class MasterCell: UITableViewCell {

   @IBOutlet private weak var titleLabel: UILabel!
   @IBOutlet private weak var exerciseLabel: UILabel!
   @IBOutlet private weak var editButton: UIButton!
   @IBOutlet private weak var checkmark: UIButton!
   @IBOutlet private weak var nextButton: UIButton!
   @IBOutlet private weak var statsLabel: UILabel!

   private var cellIsEditing = false

   struct Model {
      let title: String
      let exercise: Exercise
      let intervalType: Int16
      let intervalAmount: Int16
      let sessionComplete: Bool
      let daysElapsed: Int16
      let guiSessionCount: Int16

      init(with category: Category, and exercise: Exercise) {
         self.title = category.title ?? ""
         self.exercise = exercise
         self.intervalType = category.intervalType
         self.intervalAmount = category.intervalAmount
         self.sessionComplete = category.sessionComplete
         self.daysElapsed = category.daysElapsed
         self.guiSessionCount = category.guiSessionCount
      }
   }

   var model: Model? {
      didSet {
         guard let model = model,
            let exerciseTitle = model.exercise.title else {
            return
         }
         titleLabel.text = model.title
         exerciseLabel.formatAndDisplay(exerciseTitle, withSpacing: 0.75)
         displayButtons(for: model)
         displayStats(for: model)
      }
   }
}

// MARK: - Private Methods
extension MasterCell {
   private func displayButtons(for model: Model) {

      if cellIsEditing {
         nextButton.isHidden = true
         checkmark.isHidden = true
         return
      }

      let interval = Int(model.intervalType)
      switch interval {
      case manual:
         nextButton.isHidden = false
         checkmark.isHidden = true
      case days, activeDays:
         checkmark.isHidden = false
         nextButton.isHidden = true
      default:
         print("Error: unknown interval type")
      }

      if interval == days || interval == activeDays {
         switch model.sessionComplete {
         case true:
            checkmark.setBackgroundImage(
               UIImage(named: "Checkmark Fade"),
               for: .normal)
         default:
            checkmark.setBackgroundImage(
               UIImage(named: "Checkmark Greyed"),
               for: .normal)
         }
      }
   }

   private func displayStats(for model: Model) {
      var string = "| "
      switch Int(model.intervalType) {
      case manual:
         string += "Manual"
      case days:
         string += "Day \(model.daysElapsed + 1) of \(model.intervalAmount)"
      default:
         string += "\(model.guiSessionCount) of \(model.intervalAmount) completed"
      }
      statsLabel.text = string
   }
}

// MARK: - MasterCell Transitions
extension MasterCell {
   override func willTransition(to state: UITableViewCellStateMask) {
      super.willTransition(to: state)
      guard let model = model else {
         return
      }

      // Handle transition into cell being edited
      if state.contains(.showingEditControlMask) {
         cellIsEditing = true
         switch Int(model.intervalType) {
         case manual:
            DispatchQueue.main.asyncAfter(deadline: .now()) {
               UIView.transition(with: self.nextButton, duration: 0, options: .transitionCrossDissolve, animations: {
                  self.nextButton.isHidden = true
                  self.checkmark.isHidden = true
               })
            }
         default:
            DispatchQueue.main.asyncAfter(deadline: .now()) {
               UIView.transition(with: self.checkmark, duration: 0, options: .transitionCrossDissolve, animations: {
                  self.checkmark.isHidden = true
                  self.nextButton.isHidden = true
               })
            }
         }
      // Handle transition away from cell being edited
      } else {
         cellIsEditing = false
         switch Int(model.intervalType) {
         case manual:
            DispatchQueue.main.asyncAfter(deadline: .now()) {
               UIView.transition(with: self.nextButton, duration: 0, options: .transitionCrossDissolve, animations: {
                  self.nextButton.isHidden = false
                  self.checkmark.isHidden = true
               })
            }
         default:
            DispatchQueue.main.asyncAfter(deadline: .now()) {
               UIView.transition(with: self.checkmark, duration: 0, options: .transitionCrossDissolve, animations: {
                  self.checkmark.isHidden = false
                  self.nextButton.isHidden = true
               })
            }
         }
      }
   }
}
