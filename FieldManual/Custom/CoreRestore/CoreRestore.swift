//
//  CoreRestore.swift
//
//  Copyright © 2018 Cary Miller. (http://cmillerco.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import CoreData

class CoreRestore {
   private var supportDirectory = FileManager.default.urls(
      for: .applicationSupportDirectory,
      in: .userDomainMask)[0]

   private var documentDirectory = FileManager.default.urls(
      for: .documentDirectory,
      in: .userDomainMask)[0]

   private var backupDirectory: URL {
      return documentDirectory.appendingPathComponent("/Backups")
   }

   private let modelName: String
   private let container: NSPersistentContainer
   private let formatter = DateFormatter()
   public var appRequiresBackup = false

   public init(modelName: String, container: NSPersistentContainer) {
      self.modelName = modelName
      self.container = container
   }

   public func backup(toDirectoryURL targetDirectoryURL: URL) {
      if !FileManager.default.fileExists(atPath: targetDirectoryURL.path) {
         do {
            try FileManager.default.createDirectory(
               at: targetDirectoryURL,
               withIntermediateDirectories: false,
               attributes: nil
            )
         } catch let error {
            print("Error: Failed to create missing backup directory — \(error)")
            return
         }
      }
      let activeBaseFile = supportDirectory.path + "/\(self.modelName).sqlite"
      let activeShmFile = supportDirectory.path + "/\(self.modelName).sqlite-shm"
      let activeWalFile = supportDirectory.path + "/\(self.modelName).sqlite-wal"
      let activeBaseFileURL = URL(fileURLWithPath: activeBaseFile)
      let activeShmFileURL = URL(fileURLWithPath: activeShmFile)
      let activeWalFileURL = URL(fileURLWithPath: activeWalFile)

      let now = Date()
      formatter.timeZone = TimeZone.current
      formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
      let dateString = formatter.string(from: now)

      let backupBaseFile = targetDirectoryURL.path + "/backup_\(dateString)"
      let backupShmFile = targetDirectoryURL.path + "/backup_\(dateString)-shm"
      let backupWalFile = targetDirectoryURL.path + "/backup_\(dateString)-wal"
      let backupBaseFileURL = URL(fileURLWithPath: backupBaseFile)
      let backupShmFileURL = URL(fileURLWithPath: backupShmFile)
      let backupWalFileURL = URL(fileURLWithPath: backupWalFile)

      do {
         try FileManager.default.copyItem(at: activeBaseFileURL, to: backupBaseFileURL)
         try FileManager.default.copyItem(at: activeShmFileURL, to: backupShmFileURL)
         try FileManager.default.copyItem(at: activeWalFileURL, to: backupWalFileURL)
      } catch {
         print("Error: Failed to copy database to backup location")
      }
   }

   public func restore(fromFileURL backupFileURL: URL) {
      guard FileManager.default.fileExists(atPath: backupFileURL.path) else {
         print("Error: Backup file could not be found")
         return
      }
      let store = container.persistentStoreCoordinator.persistentStores.last!
      try? container.persistentStoreCoordinator.remove(store)

      let activeBaseFile = supportDirectory.path + "/\(self.modelName).sqlite"
      let activeShmFile = supportDirectory.path + "/\(self.modelName).sqlite-shm"
      let activeWalFile = supportDirectory.path + "/\(self.modelName).sqlite-wal"
      let activeBaseFileURL = URL(fileURLWithPath: activeBaseFile)
      let activeShmFileURL = URL(fileURLWithPath: activeShmFile)
      let activeWalFileURL = URL(fileURLWithPath: activeWalFile)

      do {
         try FileManager.default.removeItem(at: activeBaseFileURL)
         try FileManager.default.removeItem(at: activeShmFileURL)
         try FileManager.default.removeItem(at: activeWalFileURL)
      } catch {
         print("Failed to delete database components")
      }
      guard let modelURL = Bundle.main.url(
         forResource: self.modelName,
         withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
      }
      guard let managedObjectModel = NSManagedObjectModel(
         contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
      }

      let coordinator = NSPersistentStoreCoordinator(
         managedObjectModel: managedObjectModel)

      container.loadPersistentStores {
         description, error in

         do {
            try coordinator.replacePersistentStore(
               at: activeBaseFileURL,
               destinationOptions: nil,
               withPersistentStoreFrom: backupFileURL,
               sourceOptions: nil,
               ofType: NSSQLiteStoreType
            )

         } catch let error {
            print("Error: could not restore from backup -> \(error)")
         }
      }
   }

   public func pruneBackupsToMostRecent(_ targetCount: Int) {
      let backups = arrayOfBackups(sortedBy: .orderedDescending)
      guard backups.count > targetCount else {
         return
      }
      let backupsToDelete = backups.dropFirst(targetCount)
      for backup in backupsToDelete {
         let baseFile = backup.url.path
         let shmFile = backup.url.path + "-shm"
         let walFile = backup.url.path + "-wal"
         let baseFileURL = URL(fileURLWithPath: baseFile)
         let shmFileURL = URL(fileURLWithPath: shmFile)
         let walFileURL = URL(fileURLWithPath: walFile)

         do {
            try FileManager.default.removeItem(at: baseFileURL)
            try FileManager.default.removeItem(at: shmFileURL)
            try FileManager.default.removeItem(at: walFileURL)
         } catch {
            print("Failed to delete backup files")
         }
      }
   }

   public func arrayOfBackups(sortedBy: ComparisonResult) -> [CoreRestoreBackup] {
      var backups = [CoreRestoreBackup]()
      guard let allFileNames = contentsOfBackupDirectory() else {
         return backups
      }

      let backupFileNames = allFileNames
         .filter { $0.hasPrefix("backup") }
         .filter { !$0.hasSuffix("shm") }
         .filter { !$0.hasSuffix("wal") }

      for fileName in backupFileNames {
         let dateComponents = fileName.split(separator: "_")
         let timeComponents = dateComponents[2].split(separator: "-")
         let composedDate = "\(dateComponents[1])T\(timeComponents[0]):\(timeComponents[1]):\(timeComponents[2])"

         formatter.locale = Locale(identifier: "en_US_POSIX")
         formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
         let date = formatter.date(from: String(composedDate))!

         formatter.dateStyle = .medium
         formatter.timeStyle = .medium
         let dateString = formatter.string(from: date)

         let fileURL = URL(fileURLWithPath: backupDirectory.path + "/" + fileName)
         backups.append(CoreRestoreBackup(title: dateString, date: date, url: fileURL))
      }
      backups.sort { $0.date.compare($1.date) == sortedBy }
      return backups
   }

   private func contentsOfBackupDirectory() -> [String]? {
      return try? FileManager.default.contentsOfDirectory(
         atPath: backupDirectory.path
      )
   }
}

// MARK: Convenience Methods
extension CoreRestore {
   public func backup() {
      backup(toDirectoryURL: backupDirectory)
   }

   public func backupThenPrune(to targetCount: Int) {
      backup(toDirectoryURL: backupDirectory)
      pruneBackupsToMostRecent(targetCount)
   }
}
