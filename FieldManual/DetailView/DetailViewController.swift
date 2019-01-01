//
//  ExerciseViewController.swift
//  FieldManual
//
//  Created by Cary Miller on 10/12/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class DetailViewController: UIViewController {
   @IBOutlet private weak var tableView: UITableView!
   @IBOutlet private weak var categoryTitleField: UITextField!
   @IBOutlet private weak var intervalAmountField: UITextField!
   @IBOutlet private weak var intervalType: UISegmentedControl!
   @IBOutlet weak var tabBarEditButton: UIBarButtonItem!

   var category: Category!
   var exercises: NSFetchedResultsController<Exercise>!
   var coreRestore: CoreRestore!
   private var dataSource: DetailDataSource!
   private var activeTextField: UITextField!
   private var textFieldAlreadyPopulated: Bool!
   var audioClip: AudioClip!

   deinit {
      NotificationCenter.default.removeObserver(self)
   }

   override func viewDidLoad() {
      super.viewDidLoad()
      configureNavBarButtons()
      NotificationCenter.default.addObserver(self,
         selector:#selector(onInvalidCategoryAlert),
         name: .invalidCategory,
         object: nil
      )
      NotificationCenter.default.addObserver(self,
         selector: #selector(offsetTableViewFromKeyboard),
         name: NSNotification.Name.UIKeyboardWillShow,
         object: nil
      )
      NotificationCenter.default.addObserver(self,
         selector: #selector(resetTableViewToKeyboard),
         name: NSNotification.Name.UIKeyboardWillHide,
         object: nil
      )
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      configureUIElements()
      dataSource = DetailDataSource(self, tableView, category, exercises, coreRestore)
      exercises.delegate = dataSource
      tableView.dataSource = dataSource
   }

   override func setEditing(_ editing: Bool, animated: Bool) {
      super.setEditing(editing, animated: animated)
      tableView.setEditing(editing, animated: animated)
      if let textField = activeTextField {
         textField.resignFirstResponder()
      }
      switch editing {
      case true:
         tabBarEditButton.tintColor = UIColor(named: "sk_pink")!
         tabBarEditButton.image = UIImage(named: "Edit")
      case false:
         tabBarEditButton.tintColor = UIColor(named: "sk_blue")!
         tabBarEditButton.image = UIImage(named: "Edit-Thin")
      }
   }

   @IBAction func intervalTypeSelected(_ sender: UISegmentedControl) {
      audioClip.setInterval.playSound()
      coreRestore.appRequiresBackup = true
      formatIntervalAmount(type: sender.selectedSegmentIndex)
      category.setIntervalType(Int16(sender.selectedSegmentIndex))
   }

   @IBAction func tabBarEditButtonPressed(_ button: UIBarButtonItem) {
      if tableView.isEditing {
         setEditing(false, animated: true)
         audioClip.editTableViewD.playSound()
      } else {
         setEditing(true, animated: true)
         audioClip.editTableView.playSound()
      }
   }

   @objc func onInvalidCategoryAlert() {
      categoryTitleField.becomeFirstResponder()
   }
}

// MARK: - Private Methods
extension DetailViewController {
   private func configureNavBarButtons() {
      navigationItem.leftBarButtonItems = CustomBackButton.createWithText(
         text: "Back",
         color: UIColor.white,
         target: self,
         action: #selector(backButtonPressed))
   }

   private func configureUIElements() {
      categoryTitleField.text = category.title
      categoryTitleField.delegate = self
      intervalAmountField.text = String(category.intervalAmount)
      intervalAmountField.delegate = self
      intervalType.selectedSegmentIndex = Int(category.intervalType)
      formatIntervalAmount(type: Int(category.intervalType))
   }

   private func formatIntervalAmount(type: Int) {
      if type == manual {
         intervalAmountField.isEnabled = false
         intervalAmountField.alpha = 0.15
      } else {
         intervalAmountField.isEnabled = true
         intervalAmountField.alpha = 1.0
      }
   }

   @objc private func backButtonPressed() {
      prepareForUnwind()
      if tableView.isEditing {
         self.tableView.setEditing(false, animated: true)
         perform(#selector(DetailViewController.unwindToMaster),
                 with: nil,
                 afterDelay: 0.2)
      } else {
         unwindToMaster()
      }
   }

   private func prepareForUnwind() {
      exercises.delegate = nil
      if let textField = activeTextField {
         textField.resignFirstResponder()
      }
   }

   @objc private func unwindToMaster() {
      let categoryHasData = category.hasTitle()
      let exercisesHaveData = category.exercisesHaveData()
      if exercisesHaveData && !categoryHasData {
         audioClip.alert.playSound()
         presentInvalidCategoryAlert()
      } else if
         !exercisesHaveData && categoryHasData {
         audioClip.alert.playSound()
         presentInvalidExercisesAlert()
      } else {
         audioClip.goBack.playSound()
         if coreRestore.appRequiresBackup || category.hasChanges {
            category.teardown()
            coreRestore.backupThenPrune(to: maxBackupCount)
            coreRestore.appRequiresBackup = false
         } else {
            category.teardown()
         }
         if let navController = self.navigationController {
            navController.popViewController(animated: true)
         }
      }
   }

   @objc func offsetTableViewFromKeyboard(_ notification: Notification) {
      if let keyboardSize = (
         notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
      }
   }

   @objc func resetTableViewToKeyboard(_ notification: Notification) {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
   }
}

// MARK: - UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {

   @objc private func dismissKeyboard(for view: UIView) {
      view.endEditing(true)
   }

   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.endEditing(true)
      textField.resignFirstResponder()
      return false
   }

   func textFieldDidBeginEditing(_ textField: UITextField) {
      activeTextField = textField
      if textField.text != "" {
         textFieldAlreadyPopulated = true
      } else {
         textFieldAlreadyPopulated = false
      }
   }

   func textFieldDidEndEditing(_ textField: UITextField) {
      coreRestore.appRequiresBackup = true
      switch textField.accessibilityIdentifier {
      case "DetailCategoryTitleField"?:
         handleCategoryField(textField)
      case "DetailExerciseField"?:
         handleExerciseField(textField)
      case "IntervalAmountField"?:
         handleIntervalAmountField(textField)
      default:
         return
      }
   }

   private func handleCategoryField(_ textField: UITextField) {
      category.title = categoryTitleField.text
   }

   private func handleExerciseField(_ textField: UITextField) {
      guard let indexPath = tableView.indexPathOf(textField) else {
         return
      }
      switch textFieldAlreadyPopulated {
      case true:
         if textField.text.isNilOrWhitespace {
            category.deleteExercise(from: exercises, at: indexPath)
            category.syncExercisesToTableView()
         } else {
            exercises.object(at: indexPath).title = textField.text
         }
      default:
         if !textField.text.isNilOrWhitespace {
            exercises.object(at: indexPath).title = textField.text
            dataSource.increaseTableViewPad()
         }
      }
   }

   private func handleIntervalAmountField(_ textField: UITextField) {
      guard var input = Int16(textField.text!) else {
         category.intervalAmount = 1
         intervalAmountField.text = "1"
         return
      }
      if input <= 0 {
         input = 1
         intervalAmountField.text = "1"
      }
      category.intervalAmount = input
      if category.guiSessionCount > input {
         category.guiSessionCount = input
      }
   }
}
