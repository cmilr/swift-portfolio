//
//  ExerciseDataSource.swift
//  Dalilah
//
//  Created by Cary Miller on 11/7/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit
import CoreData

class DetailDataSource: NSObject {
   private unowned var detailViewController: DetailViewController
   private var tableView: UITableView
   private var category: Category
   private var exercises: NSFetchedResultsController<Exercise>
   private var coreRestore: CoreRestore
   private var invalidExercisesAlert = false
   var cellsBeingEdited = false
   
   init(_ detailViewController: DetailViewController,
        _ tableView: UITableView,
        _ category: Category,
        _ exercises: NSFetchedResultsController<Exercise>,
        _ coreRestore: CoreRestore) {

      self.detailViewController = detailViewController
      self.tableView = tableView
      self.category = category
      self.exercises = exercises
      self.coreRestore = coreRestore
   }
}

// MARK: - UITableViewDataSource
extension DetailDataSource: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      guard let exercises = category.exercises else {
         return 0
      }
      return exercises.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailCell else {
         fatalError("Unexpected Index Path")
      }
      configure(cell: cell, for: indexPath)
      return cell
   }
   
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      if tableView.isEditing {
         return true
      }
      return false
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         category.deleteExercise(from: exercises, at: indexPath)
         category.syncExercisesToTableView()
         exercises = category.fetchExercises()
         tableView.reloadData()
      }
   }

   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      cellsBeingEdited = true
      category.syncExercisesToTableView(sourceIndexPath, destinationIndexPath)
      exercises = category.fetchExercises()
      cellsBeingEdited = false
      tableView.reloadData()
   }
}

// MARK: - Public Methods
extension DetailDataSource {
   public func increaseTableViewPad() {
      cellsBeingEdited = true
      category.addNewExerciseToPadTableView()
      exercises = category.fetchExercises()
      let endSlot = exercises.fetchedObjects?.count
      let endIndex = IndexPath(row: endSlot! - 1, section: 0)
      tableView.insertRows(at: [endIndex], with: .automatic)
      cellsBeingEdited = false
   }
}

// MARK: - Private Methods
extension DetailDataSource {
   private func configure(cell: UITableViewCell, for indexPath: IndexPath) {
      guard let cell = cell as? DetailCell,
         let exerciseCount = category.exercises?.count else {
            return
      }
      let index = indexPath.row
      if exerciseCount > index {
         let exercise = exercises.object(at: indexPath)
         cell.model = DetailCell.Model(for: exercise)
      }
      cell.setTextFieldDelegate(detailViewController)
   }
}

// MARK: - NSFetchedResultsControllerDelegate
extension DetailDataSource: NSFetchedResultsControllerDelegate {
   
   func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      if cellsBeingEdited { return }
      tableView.beginUpdates()
   }
   
   func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
      didChange anObject: Any,
      at indexPath: IndexPath?,
      for type: NSFetchedResultsChangeType,
      newIndexPath: IndexPath?) {
      
      if cellsBeingEdited { return }
      switch type {
      case .insert:
         tableView.insertRows(at: [newIndexPath!], with: .automatic)
      case .delete:
         tableView.deleteRows(at: [indexPath!], with: .automatic)
      case .update:
         if let cell = tableView.cellForRow(at: indexPath!) as? DetailCell {
            configure(cell: cell, for: indexPath!)
         }
      case .move:
         tableView.deleteRows(at: [indexPath!], with: .automatic)
         tableView.insertRows(at: [newIndexPath!], with: .automatic)
      }
   }
   
   func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      coreRestore.appRequiresBackup = true
      if cellsBeingEdited { return }
      tableView.endUpdates()
   }
}
