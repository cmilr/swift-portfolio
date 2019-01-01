//
//  DebugUIAlert.swift
//  Dalilah
//
//  Created by Cary Miller on 12/10/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import Foundation
import UIKit

func debugUIAlert(_ alertString: String) {
#if DEBUG
   let alert = UIAlertController(
      title: "DebugUIAlert",
      message: "\(alertString)",
      preferredStyle: .alert)

   alert.addAction(UIAlertAction(
      title: "OK",
      style: .default,
      handler: nil
   ))

   UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
#else
   print("\nDebugUIAlert\n\(alertString)\n\n")
#endif
}
