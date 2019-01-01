//
//  UIView+Ext.swift
//  Dalilah
//
//  Created by Cary Miller on 12/6/17.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit

extension UIView {

   // This view is both designable, and impervious to being cleared.
   // It can be used in situations where you don't want a subview to
   // go transparent during TableViewCell editing, etc.
   @IBDesignable
   class DesignableOpaqueView: UIView {
      override var backgroundColor: UIColor? {
         didSet {
            if UIColor.clear.isEqual(backgroundColor) {
               backgroundColor = oldValue
            }
         }
      }
   }
}
