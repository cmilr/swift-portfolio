//
//  UIView+Animations.swift
//  Dalilah
//
//  Created by Cary Miller on 3/1/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
   func popInAnimation() {
      UIView.animate(
         withDuration: 0.45,
         delay: 0.2,
         usingSpringWithDamping: 0.4,
         initialSpringVelocity: 10,
         options: .curveEaseInOut,
         animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
         },
         completion: { _ in
         }
   )
   }

   func popOutAnimation() {
      UIView.animate(
         withDuration: 0.10,
         delay: 0,
         usingSpringWithDamping: 0.5,
         initialSpringVelocity: 20,
         options: .curveEaseOut,
         animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
      },
         completion: { _ in
      }
      )
      UIView.animate(
         withDuration: 0.30,
         delay: 0.15,
         usingSpringWithDamping: 1,
         initialSpringVelocity: 10,
         options: .curveEaseInOut,
         animations: {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
         },
         completion: { _ in
         }
      )
   }
}
