//
//  CategoryDataSource.swift
//  FieldManual
//
//  Created by Cary Miller on 11/7/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit
import CoreData

class MasterDataSource: NSObject {

   var coreRestore: CoreRestore
   var tableView: UITableView
   var categories: NSFetchedResultsController<Category>
   var cellsBeingEdited = false
   
   init(_ categories: NSFetchedResultsController<Category>,
        _ tableView: UITableView,
        _ coreRestore: CoreRestore) {

      self.tableView = tableView
      self.categories = categories
      self.coreRestore = coreRestore
   }
}

// MARK: - UITableViewDataSource
extension MasterDataSource: UITableViewDataSource {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      guard let sections = categories.sections else {
         return 0
      }
      return sections.count
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      guard let count = categories.fetchedObjects?.count else {
         return 0
      }
      return count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath) as? MasterCell else {
         fatalError("Unexpected Index Path")
      }
      configure(cell: cell, for: indexPath)
      return cell
   }
   
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      if tableView.isEditing {
         return true
      } else {
         return false
      }
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         let category = categories.object(at: indexPath)
         category.requestDeletion()
         categories.syncToTableView(categories)
      }
   }

   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      cellsBeingEdited = true
      categories.syncToTableView(categories, sourceIndexPath, destinationIndexPath)
      cellsBeingEdited = false
   }
}

// MARK: - Private Methods
extension MasterDataSource {
   
   private func configure(cell: UITableViewCell, for indexPath: IndexPath) {
      guard let cell = cell as? MasterCell else {
         fatalError("Cell Not Returned")
      }
      let category = categories.object(at: indexPath)
      guard let exercises = category.exercises else {
         debugUIAlert("Category \"\(category.title!)\" has no exercises set")
         return
      }
      guard exercises.count > 0  else {
         debugUIAlert("Category \"\(category.title!)\" has an exercise count of zero")
         return
      }
      guard let activeExercise = category.activeExercise else {
         debugUIAlert("Category \"\(category.title!)\" has no active exercise")
         return
      }
      cell.model = MasterCell.Model(with: category, and: activeExercise)
   }
}

// MARK: - NSFetchedResultsControllerDelegate
extension MasterDataSource: NSFetchedResultsControllerDelegate {
   
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
         if let cell = tableView.cellForRow(at: indexPath!) as? MasterCell {
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
