//
//  DateKitUI.swift
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

import UIKit

/**
 DateKitUI extends the functionality of DateKit by giving you full control of
 mocked dates in your Xcode UI tests. Since you can't access the inner workings
 of your app during UI testing, DateKitUI employs a nearly-hidden UITextField
 element to allow you to enter date-strings via the UI instead.
 */

class DateKitUI: UITextField, UITextFieldDelegate {
    static let shared = DateKitUI()

    private init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        configure()
    }

    internal required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }

    internal required override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    func configure() {
        if ProcessInfo.processInfo.arguments.contains("uitest") {
            delegate = self
            accessibilityIdentifier = "DateKitUI"
            isUserInteractionEnabled = true
            backgroundColor = UIColor.clear
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            fatalError("Could not retrieve text from textField.")
        }
        DateKit.mockCurrentDate(as: text)
        textField.text = ""
        #if DEBUG
        print("Date Set --> \(text)")
        #endif
    }
}
