//
//  MasterViewController.swift
//  Dalilah
//
//  Created by Cary Miller on 10/11/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UIViewController {
   @IBOutlet private weak var tableView: UITableView!
   @IBOutlet private weak var addButton: UIButton!
   @IBOutlet private weak var tabBarEditButton: UIBarButtonItem!

   private var dataSource: MasterDataSource!
   var categories: NSFetchedResultsController<Category>!
   var coreRestore: CoreRestore!
   var coreLogic: CoreLogic!
   var audioClip: AudioClip!
   var dataWasChanged = false

   deinit {
      NotificationCenter.default.removeObserver(self)
   }

   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.estimatedRowHeight = 170
      tableView.rowHeight = UITableViewAutomaticDimension
      setNeedsStatusBarAppearanceUpdate()
      configureAddButton()
      DateKit.enableUITests(view: view)
   }

   override var preferredStatusBarStyle : UIStatusBarStyle {
      return .lightContent
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      categories = coreLogic.fetchCategories()
      dataSource = MasterDataSource(categories, tableView, coreRestore)
      categories.delegate = dataSource
      tableView.dataSource = dataSource
      addButton.isUserInteractionEnabled = true
      addButton.popInAnimation()
      animateTableView()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      categories.delegate = nil
      addButton.isUserInteractionEnabled = false
      addButton.popOutAnimation()
   }

   @objc func animateTableView() {
      tableView.reloadData()
      let zoomAnimation = AnimationType.zoom(
         scale: 0.2
      )
      UIView.animate(
         views: tableView.visibleCells,
         animations: [zoomAnimation],
         delay: 0.0,
         duration: 0.45)
   }

   override func setEditing(_ editing: Bool, animated: Bool) {
      super.setEditing(editing, animated: animated)
      tableView.setEditing(editing, animated: animated)
      switch editing {
      case true:
         tabBarEditButton.tintColor = UIColor(named: "sk_pink")!
         tabBarEditButton.image = UIImage(named: "Edit")
         DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.transition(
               with: self.tableView,
               duration: 0.1,
               options: .transitionCrossDissolve,
               animations: {
                  self.tableView.reloadData()
            })
         }
      default:
         tabBarEditButton.tintColor = UIColor(named: "sk_blue")!
         tabBarEditButton.image = UIImage(named: "Edit-Thin")
         DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.transition(
               with: self.tableView,
               duration: 0.1,
               options: .transitionCrossDissolve,
               animations: {
                  self.tableView.reloadData()
            })
         }
         if coreRestore.appRequiresBackup {
            coreRestore.appRequiresBackup = false
            coreRestore.backupThenPrune(to: maxBackupCount)
         }
      }
   }

   @IBAction func checkmarkButtonPressed(_ checkmark: UIButton) {
      if let indexPath = tableView.indexPathOf(checkmark) {
         let category = categories.object(at: indexPath)
         category.updateSessionStatus()
         let sessionComplete = category.sessionStatus()
         if sessionComplete {
            checkmark.setBackgroundImage(UIImage(named: "Checkmark Fade"), for: .normal)
            audioClip.sessionComplete.playSound()
            category.incrementGUISessionCount()
         } else {
            checkmark.setBackgroundImage(UIImage(named: "Checkmark Greyed"), for: .normal)
            audioClip.sessionCompleteD.playSound()
            category.decrementGUISessionCount()
         }
      }
   }

   @IBAction func nextButtonPressed(_ button: UIButton) {
      audioClip.nextCategory.playSound()
      if let indexPath = tableView.indexPathOf(button) {
         let category = categories.object(at: indexPath)
         coreLogic.handleManualRotationIfRequired(for: category)
      }
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

   @IBAction func addButtonPressed(_ sender: UIButton) {
      categories.delegate = nil
      audioClip.addCategory.playSound()
      if tableView.isEditing {
         self.tableView.setEditing(false, animated: true)
         self.isEditing = false
         delayFor(seconds: 0.02) { () in
            self.performSegue(
               withIdentifier: "AddNewCategory",
               sender: sender)
         }
      } else {
         performSegue(
            withIdentifier: "AddNewCategory",
            sender: sender)
      }
   }

   @IBAction func cellEditButtonPressed(_ sender: UIButton) {
      categories.delegate = nil
      audioClip.editCell.playSound()
      if tableView.isEditing {
         self.tableView.setEditing(false, animated: true)
         self.isEditing = false
         tabBarEditButton.tintColor = UIColor(named: "sk_blue")!
         tabBarEditButton.image = UIImage(named: "Edit-Thin")
      }
      performSegue(
         withIdentifier: "EditExistingCategory",
         sender: sender
      )
   }

   func configureAddButton() {
      self.navigationController?.view.addSubview(addButton)
      // Handle visual bug in iPhone 8 Plus and smaller, when running iOS 12
      if #available(iOS 12.0, *), UIScreen.main.bounds.height <= 736 {
         guard let window = UIApplication.shared.keyWindow else {
            return
         }
         let topPadding = window.safeAreaInsets.top
         addButton.frame = addButton.frame.offsetBy(
            dx: 0,
            dy: (topPadding / 2) - 8
         )
         return
      }
      // Handle all other cases
      if #available(iOS 11.0, *) {
         guard let window = UIApplication.shared.keyWindow else {
            return
         }
         let topPadding = window.safeAreaInsets.top
         addButton.frame = addButton.frame.offsetBy(
            dx: 0,
            dy: (topPadding / 2)
         )
      }
   }
}

// MARK: - Segues
extension MasterViewController {

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      super.prepare(for: segue, sender: sender)
      if tableView.isEditing {
         self.tableView.setEditing(false, animated: false)
         self.isEditing = false
      }
      switch segue.identifier! {
      case "AddNewCategory":
         if let detailViewController = segue.destination as? DetailViewController {
            let category = categories.initializeNewCategory()
            detailViewController.category = category
            detailViewController.exercises = category.fetchExercises()
            detailViewController.audioClip = audioClip
            detailViewController.coreRestore = coreRestore
         }
      case "EditExistingCategory":
         if let detailViewController = segue.destination as? DetailViewController {
            if let button: UIButton = sender as! UIButton?,
               let indexPath = tableView.indexPathOf(button) {
               let category = categories.object(at: indexPath)
               category.addTempExercises()
               detailViewController.category = category
               detailViewController.exercises = category.fetchExercises()
               detailViewController.audioClip = audioClip
               detailViewController.coreRestore = coreRestore
            }
         }
      case "ShowSettingsScreen":
         audioClip.showSettings.playSound()
         if let settingsTableViewController = segue.destination as? SettingsTableViewController {
            settingsTableViewController.masterController = self
            settingsTableViewController.coreRestore = coreRestore
            settingsTableViewController.audioClip = audioClip
         }
      default:
         break
      }
   }
}
