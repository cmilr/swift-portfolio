//
//  DetailViewAlerts.swift
//  FieldManual
//
//  Created by Cary Miller on 12/14/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit

extension Notification.Name {
   static let invalidCategory = Notification.Name("InvalidCategory")
   static let invalidExercises = Notification.Name("InvalidExercises")
}

extension DetailViewController {
   func presentInvalidCategoryAlert() {
      let alert = UIAlertController(
         title: "Would you like to to save these exercises?",
         message: "Please add a category title.",
         preferredStyle: .alert
      )
      
      alert.addAction(UIAlertAction(
         title: "Add category title",
         style: .default,
         handler: { _ in
            NotificationCenter.default.post(
               name: .invalidCategory,
               object: nil)
      }))

      alert.addAction(UIAlertAction(
         title: "Discard these exercises",
         style: .destructive,
         handler: { _ in
            self.category.requestDeletion()
            if let navController = self.navigationController {
               navController.popViewController(animated: true)
            }
      }))

      present(alert, animated: true, completion: nil)
   }
   
   func presentInvalidExercisesAlert() {
      let alert = UIAlertController(
         title: "Would you like to save this category?",
         message: "Please add at least one exercise.",
         preferredStyle: .alert
      )

      alert.addAction(UIAlertAction(
         title: "Add exercises",
         style: .default,
         handler: nil
      ))

      alert.addAction(UIAlertAction(
         title: "Discard this category",
         style: .destructive,
         handler: { _ in
            self.category.requestDeletion()
            if let navController = self.navigationController {
               navController.popViewController(animated: true)
            }
      }))

      present(alert, animated: true, completion: nil)
   }
}
