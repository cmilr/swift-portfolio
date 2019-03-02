//
//  UILabel+Ext.swift
//  Dalilah
//
//  Created by Cary Miller on 8/10/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
   // swiftlint:disable legacy_constructor
   public func formatAndDisplay(_ string: String, withSpacing spacing: Float) {
      let attr = NSMutableAttributedString(string: string)
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = 1.0
      paragraphStyle.lineHeightMultiple = CGFloat(spacing)
      attr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attr.length))
      self.attributedText = attr
   }
   // swiftlint:enable legacy_constructor
}
