//
//  RestoreViewController.swift
//  Dalilah
//
//  Created by Cary Miller on 10/24/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit

class RestoreViewController: UIViewController {

   @IBOutlet weak var tableView: UITableView!
   var coreRestore: CoreRestore!
   var audioClip: AudioClip!
   var masterController: MasterViewController!
   var backups = [CoreRestoreBackup]()
   let formatter = DateFormatter()
   var selectedBackup: URL?

   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
      NotificationCenter.default.addObserver(
         self,
         selector: #selector(willEnterForeground),
         name: .UIApplicationWillEnterForeground,
         object: nil
      )
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      configureBackups()
      selectedBackup = nil
      tableView.reloadData()
   }

   @objc func willEnterForeground() {
      configureBackups()
      tableView.reloadData()
   }

   func configureBackups() {
      backups.removeAll()
      backups = coreRestore.arrayOfBackups(sortedBy: .orderedDescending)
   }
   
   @IBAction func restoreButtonPressed(_ sender: Any) {
      masterController.categories = nil
      if let selectedBackup = selectedBackup {
         coreRestore.restore(fromFileURL: selectedBackup)
      }
      self.navigationController?.popViewController(animated: true)
   }
}

extension RestoreViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return backups.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestoreCell", for: indexPath) as? RestoreCell else {
         fatalError("Unexpected Index Path")
      }
      cell.backupTitleLabel?.text = backups[indexPath.row].title
      cell.selectionStyle = .gray
      return cell
   }
}

extension RestoreViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      selectedBackup = backups[indexPath.row].url
   }

   func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      selectedBackup = nil
   }
}
