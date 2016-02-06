//
//  MemeMeTextFieldDelegate.swift
//  MemeMe v1.0
//
//  Created by Latchezar Mladenov on 12/16/15.
//  Copyright © 2015 Latchezar Mladenov. All rights reserved.
//

import Foundation
import UIKit

class MemeMeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var topTextField: UITextField! = nil
    var bottomTextField: UITextField! = nil
    var activeTextField: UITextField! = nil
    
    init(topTextField: UITextField, bottomTextField: UITextField) {
        super.init()
        self.topTextField = topTextField
        self.bottomTextField = bottomTextField
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }

        self.activeTextField = textField
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.capitalizedString != string {
            textField.text = textField.text! + string.capitalizedString
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
    
}