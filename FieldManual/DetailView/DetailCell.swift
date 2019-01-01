//
//  ExerciseCell.swift
//  FieldManual
//
//  Created by Cary Miller on 10/23/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
   @IBOutlet private weak var exerciseField: UITextField!
   
   struct Model {
      let title: String
      let speed: Int16

      init(for exercise: Exercise) {
         title = exercise.title ?? ""
         speed = exercise.speed
      }
   }

   var model: Model? {
      didSet {
         guard let model = model else {
            return
         }
         exerciseField.text = model.title
      }
   }
}

extension DetailCell {
   func setTextFieldDelegate(_ delegate: UITextFieldDelegate) {
      exerciseField.delegate = delegate
   }
}
