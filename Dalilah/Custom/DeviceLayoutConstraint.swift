//
//  DeviceLayoutConstraint.swift
//  Dalilah
//
//  Created by Cary Miller on 10/29/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//
//  Sets both horizontal and vertical constraints to a percentage of the *width*
//  of the device's screen, allowing for constraint constants that are both
//  dynamic AND matched for any orientation.
//
//  Constraints for iPad models are set separately, as they often require a
//  different percentage than other devices to be aesthetically pleasing.

import UIKit

class DeviceLayoutConstraint: NSLayoutConstraint {

   @IBInspectable var iPhonePerc: CGFloat = 0
   @IBInspectable var iPadPerc: CGFloat = 0

   var screenSize: (width: CGFloat, height: CGFloat) {
      return (UIScreen.main.bounds.width, UIScreen.main.bounds.height)
   }

   var orientation: UIDeviceOrientation {
      return UIDevice.current.orientation
   }

   override func awakeFromNib() {
      super.awakeFromNib()
      configure()
   }

   func configure() {
      guard iPhonePerc > 0, iPadPerc > 0 else { return }
      let screenHeight = screenSize.height
      let screenWidth = screenSize.width

      switch firstAttribute {
      case .leading, .leadingMargin, .trailing, .trailingMargin,
           .top, .topMargin, .bottom, .bottomMargin:

         if
            ((orientation == .portrait || orientation == .portraitUpsideDown)
               && screenWidth < 768)

            ||

            ((orientation == .landscapeLeft || orientation == .landscapeRight)
               && screenWidth < 1024) {

            constant = screenHeight * iPhonePerc
         } else {
            constant = screenHeight * iPadPerc
         }

      default:
         print("🤖 Caution: DeviceLayoutConstraint doesn't currently support \(firstAttribute)")
      }
   }
}
