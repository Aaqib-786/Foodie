//
//  SignUpViewController.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import UIKit
import NVActivityIndicatorView

class SignUpViewController: UIViewController {
    
    static func instantiate() -> SignUpViewController {
        let name = String(describing: SignUpViewController.self)
        let storyboard = UIStoryboard(name: "SignUpViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as! SignUpViewController
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var signUpBtn: UIButton!
    
    private let authManager = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UiInItilizers()
    }
    
    private func UiInItilizers() {
        activityIndicatorView.type = .ballRotateChase
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: AppConstants.PlaceHolders.email,
                                                                      attributes: [.foregroundColor: UIColor.lightGray])
        
        self.passTextField.attributedPlaceholder = NSAttributedString(string: AppConstants.PlaceHolders.password,
                                                                      attributes: [.foregroundColor: UIColor.lightGray])
        
        self.confirmPassTextField.attributedPlaceholder = NSAttributedString(string: AppConstants.PlaceHolders.confirmPassword,
                                                                      attributes: [.foregroundColor: UIColor.lightGray])
        
        self.signupUIElements(views: [emailTextField, passTextField, signUpBtn, confirmPassTextField], borderColor: UIColor.lightGray, borderWidth: 0.5, cornerRadius: 9)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let email = emailTextField.text!
        let password = passTextField.text!
        let confirmPassword = confirmPassTextField.text!
        
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            self.signUpBtn.isEnabled = false
            self.signUpBtn.backgroundColor = Color.veryLightBlue
            self.signUpBtn.setTitleColor(Color.coolGray, for: .normal)
        } else {
            if Utils.isValidEmail(enteredEmail: email) {
                self.signUpBtn.isEnabled = true
                self.signUpBtn.backgroundColor = UIColor.black
                self.signUpBtn.setTitleColor(UIColor.white, for: .normal)
                self.signUpBtn.layer.borderColor = Color.lightSkyBlue.cgColor
            } else {
                self.signUpBtn.backgroundColor = Color.veryLightBlue
                self.signUpBtn.setTitleColor(Color.coolGray, for: .normal)
                self.signUpBtn.isEnabled = false
                self.emailTextField.layer.borderColor = Color.coralPink.cgColor
            }
        }
    }
    
    private func signUp() {
        let email = emailTextField.text!
        let password = passTextField.text!
        let confirmPassword = confirmPassTextField.text!
        
        if password != confirmPassword {
            Utils.showAlert(title: "Error", message: AppConstants.Keys.noMatchPassword)
        } else {
            self.activityIndicatorView.startAnimating()
            authManager.createUser(email: email, password: password) { result, error in
                self.activityIndicatorView.stopAnimating()
                if let result = result {
                    let user = result.user
                    print("Successfull Signup: \(user.uid)")
                    let vc = LoginViewController.instantiate()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                } else {
                    Utils.showAlert(title: "Error", message: error!.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func signupBtnTapped(_ sender: UIButton) {
        self.signUp()
    }
    
    @IBAction func signinBtnTapped(_ sender: UIButton) {
        let vc = LoginViewController.instantiate()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension SignUpViewController {
    func signupUIElements(views: [UIControl], borderColor: UIColor = .black, borderWidth: CGFloat = 0.0, cornerRadius: CGFloat = 0.0) {
        for view in views {
            if let view = view as? UITextField {
                view.layer.cornerRadius = cornerRadius
                view.layer.borderWidth = borderWidth
                view.layer.borderColor = borderColor.cgColor
                view.layer.applySketchShadow(color: Color.shadowColor, alpha: 0.1, x: 0, y: 1, blur: 5, spread: 0)
                view.setLeftPaddingPoints(12)
                view.delegate = self
                view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }
            
            if let view = view as? UIButton {
                view.layer.cornerRadius = cornerRadius
                view.isEnabled = false
            }
        }
    }
}
