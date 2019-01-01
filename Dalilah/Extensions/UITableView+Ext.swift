//
//  UITableView+Ext.swift
//  Dalilah
//
//  Created by Cary Miller on 12/3/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {

   /// Returns IndexPath of any view residing within a cell
   func indexPathOf(_ view: UIView) -> IndexPath? {
      var parent = view.superview
      while
         type(of: parent) != UITableViewCell.self &&
            parent?.superclass != UITableViewCell.self {
               parent = parent?.superview
      }

      let cell = parent as! UITableViewCell
      let indexPath = self.indexPath(for: cell)
      return indexPath
   }

   func scrollToTop() {
      let indexPath = IndexPath(row: 0, section: 0)
      self.scrollToRow(at: indexPath, at: .top, animated: true)
   }

   func deselectAllCells() {
      let numberOfSections = self.numberOfSections
      for section in 0..<numberOfSections {
         let numberOfRows = self.numberOfRows(inSection: section)
         for row in 0..<numberOfRows {
            self.deselectRow(at: IndexPath(row: row, section: section), animated: false)
         }
      }
   }
}
