//
//  SettingsTableViewController.swift
//  FieldManual
//
//  Created by Cary Miller on 12/11/18.
//  Copyright © 2018 Cary Miller. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController {

   @IBOutlet weak var versionAndBuildLabel: UILabel!
   var coreRestore: CoreRestore!
   var audioClip: AudioClip!
   var masterController: MasterViewController!

   override func viewDidLoad() {
      super.viewDidLoad()
      versionAndBuildLabel.text = versionAndBuild()
   }

   override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
      let header = view as! UITableViewHeaderFooterView
      header.textLabel?.textColor = UIColor(named: "sk_blueDark")
      header.textLabel?.font = UIFont(name: "Zilla Slab", size: 17)
      header.textLabel?.frame = header.frame
      header.textLabel?.textAlignment = NSTextAlignment.left
   }

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let settings = 0
      let feedback = 1
      let community = 2
      let privacy = 3

      switch indexPath {
      // Segue to Restore Screen
      case [settings, 0]:
         performSegue(withIdentifier: "ShowRestoreScreen", sender: nil)

      // Send Support Email
      case [feedback, 0]:
         sendEmail()

      // Send Support Tweet
      case [feedback, 1]:
         if let url = URL(string: "https://twitter.com/intent/tweet?text=@cmillerco") {
            UIApplication.shared.open(url, options: [:])
         }

      // Visit Our Website
      case [community, 0]:
         if let url = URL(string: "https://cmillerco.com") {
            UIApplication.shared.open(url, options: [:])
         }

      // Sign-Up For Mailing List
      case [community, 1]:
         if let url = URL(string: "http://eepurl.com/ga0vnP") {
            UIApplication.shared.open(url, options: [:])
         }

      // Read Privacy Policy
      case [privacy, 0]:
         if let url = URL(string: "https://cmillerco.com/privacy") {
            UIApplication.shared.open(url, options: [:])
         }

      default: break
      }
   }

   func versionAndBuild() -> String {
      let dictionary = Bundle.main.infoDictionary!
      let version = dictionary["CFBundleShortVersionString"] as! String
      let build = dictionary["CFBundleVersion"] as! String
      return "version \(version)  |  build \(build)"
   }

   func versionAndBuildEmailDiagnostics() -> String {
      let dictionary = Bundle.main.infoDictionary!
      let version = dictionary["CFBundleShortVersionString"] as! String
      let build = dictionary["CFBundleVersion"] as! String
      return "Dalilah version \(version) | build \(build)"
   }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      super.prepare(for: segue, sender: sender)
      switch segue.identifier! {
      case "ShowRestoreScreen":
         if let restoreViewController = segue.destination as? RestoreViewController {
            restoreViewController.masterController = masterController
            restoreViewController.coreRestore = coreRestore
            restoreViewController.audioClip = audioClip
         }
      default:
         break
      }
   }
}

extension SettingsTableViewController: MFMailComposeViewControllerDelegate {

   func configureMailController() -> MFMailComposeViewController {
      let messageString = """
      🚀 \(versionAndBuildEmailDiagnostics())
      ~~~~~~~~~~~~~~~~~~~~~~~~



      """
      let mailComposerVC = MFMailComposeViewController()
      mailComposerVC.mailComposeDelegate = self
      mailComposerVC.setToRecipients(["support@cmillerco.com"])
      mailComposerVC.setSubject("Dalilah Support Request")
      mailComposerVC.setMessageBody(messageString, isHTML: false)
      return mailComposerVC
   }

   func showMailError() {
      let alert = UIAlertController(
         title: "We're sorry about that...",
         message: "Your device won't allow us to send email right now. Please check out our settings page for more ways to reach us.",
         preferredStyle: .alert
      )

      alert.addAction(UIAlertAction(
         title: "Ok",
         style: .default,
         handler: nil)
      )
      self.present(alert, animated: true, completion: nil)
   }

   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true, completion: nil)
   }

   func sendEmail() {
      let mailComposeViewController = configureMailController()
      if MFMailComposeViewController.canSendMail() {
         self.present(mailComposeViewController, animated: true, completion: nil)
      } else {
         showMailError()
      }
   }
}
