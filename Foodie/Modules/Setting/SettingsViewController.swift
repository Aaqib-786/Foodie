//
//  SettingsViewController.swift
//  Foodie
//
//  Created by Aaqib Seliya on 09/12/2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    static func instantiate() -> SettingsViewController {
        let name = String(describing: SettingsViewController.self)
        let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as! SettingsViewController
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutbtnTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            appDelegate.showLoginView()
        } catch let error {
            Utils.showAlert(title: "Errror!", message: error.localizedDescription)
        }
    }
}
