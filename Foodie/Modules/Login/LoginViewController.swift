//
//  LoginViewController.swift
//  Foodie
//
//  Created by Aaqib Seliya on 09/12/2022.
//

import UIKit
import AuthenticationServices
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    
    static func instantiate() -> LoginViewController {
        let name = String(describing: LoginViewController.self)
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as! LoginViewController
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    private let authManager = AuthService()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UiInitilizers()
    }
    
    private func UiInitilizers() {
        activityIndicatorView.type = .ballRotateChase
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: AppConstants.PlaceHolders.email,
                                                                       attributes: [.foregroundColor: UIColor.lightGray])
        self.passTextField.attributedPlaceholder = NSAttributedString(string: AppConstants.PlaceHolders.password,
                                                                      attributes: [.foregroundColor: UIColor.lightGray])
        
        self.loginUIElements(views: [emailTextField, passTextField, signinBtn],
                             borderColor: UIColor.lightGray, borderWidth: 0.5, cornerRadius: 9)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let email = emailTextField.text!
        let password = passTextField.text!
        
        if email.isEmpty || password.isEmpty {
            self.signinBtn.isEnabled = false
            self.signinBtn.backgroundColor = Color.veryLightBlue
            self.signinBtn.setTitleColor(Color.coolGray, for: .normal)
        } else {
            if Utils.isValidEmail(enteredEmail: email) {
                self.signinBtn.isEnabled = true
                self.signinBtn.backgroundColor = UIColor.black
                self.signinBtn.setTitleColor(UIColor.white, for: .normal)
                self.emailTextField.layer.borderColor = Color.lightSkyBlue.cgColor
            } else {
                self.signinBtn.backgroundColor = Color.veryLightBlue
                self.signinBtn.setTitleColor(Color.coolGray, for: .normal)
                self.signinBtn.isEnabled = false
                self.emailTextField.layer.borderColor = Color.coralPink.cgColor
            }
        }
    }
    
    @IBAction func signupTapped(_ sender: UIButton) {
        let vc = SignUpViewController.instantiate()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func login() {
        let email = emailTextField.text!
        let password = passTextField.text!
        
        activityIndicatorView.startAnimating()
        authManager.signInWithEmail(email: email, password: password) {[weak self] (authResult, error) in
            self?.activityIndicatorView.stopAnimating()
            guard let self = self else {return}
            if let _ = authResult {
                print("Success Login")
                self.appDelegate.showMainView()
                
            } else {
                Utils.showAlert(title: "Error!", message: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        self.login()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text!
        if textField == emailTextField {
            if text.count > 0 && !Utils.isValidEmail(enteredEmail: text) {
                self.emailTextField.layer.borderColor = Color.coralPink.cgColor
            } else {
                self.emailTextField.layer.borderColor = Color.lightSkyBlue.cgColor
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            self.login()
        }
        return true
    }
}

extension LoginViewController {
    func loginUIElements(views: [UIControl], borderColor: UIColor = .black, borderWidth: CGFloat = 0.0, cornerRadius: CGFloat = 0.0) {
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
