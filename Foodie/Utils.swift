//
//  Utils.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import UIKit

class Utils: NSObject {
    public typealias EmptyCompletion = () -> Void
    
    static var isAlertShowing = false
    class var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    class func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithCustomButton(buttonTitle: String, title: String, message: String = "", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
                completion?()
            }))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func isValidEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }
}
