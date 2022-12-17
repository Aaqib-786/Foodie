//
//  UITextField.swift
//  Foodie
//
//  Created by Aaqib Seliya on 09/12/2022.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: self.font!
        ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
    
    func shouldMoveToNextField(textField:UITextField, string: String) -> Bool {
        if !string.canBeConverted(to: String.Encoding.ascii){
                return false
            }
        //Check if textField has 1 chacrater
        if string.count > 0 {
            let nextTag = textField.tag + 1
            
            // get next responder
            var nextResponder = textField.superview?.superview?.viewWithTag(nextTag)
            
            if (nextResponder == nil) {
                nextResponder = textField.superview?.viewWithTag(0)
            }

            textField.text = string.uppercased()
            //write here your last textfield tag
            if textField.tag == 132 {
                //Dissmiss keyboard on last entry
                //textField.resignFirstResponder()
            } else {
                ///Appear keyboard
                nextResponder?.becomeFirstResponder()
            }
            nextResponder?.becomeFirstResponder()
            return false;
        } else if string.count == 0 {// on deleteing value from Textfield

            let previousTag = textField.tag - 1;
            // get prev responder
            var previousResponder = textField.superview?.superview?.viewWithTag(previousTag);
            if (previousResponder == nil) {
                previousResponder = textField.superview?.viewWithTag(0);
            }
            textField.text = "";
            previousResponder?.becomeFirstResponder();
            return false
        }
        return true
    }
}
