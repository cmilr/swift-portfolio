//
//  UIImageView+Ext.swift
//  Dalilah
//
//  Created by Cary Miller on 8/21/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit

public extension UIImageView {
   public func transition(toImage image: UIImage?) {
      UIView.transition(
         with: self,
         duration: 0.3,
         options: [.transitionCrossDissolve],
         animations: {
            self.image = image
         },
         completion: nil
      )
   }
}
