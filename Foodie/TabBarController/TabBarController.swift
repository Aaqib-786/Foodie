//
//  TabBarController.swift
//  Foodie
//
//  Created by Aaqib Seliya on 09/12/2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override var selectedIndex: Int {
        didSet {
            guard let selectedViewController = viewControllers?[selectedIndex] else {
                return
            }
            selectedViewController.tabBarItem.setTitleTextAttributes([.font: BrandonGrotesque.bold.of(size: 13)!,
                                                                      .foregroundColor: UIColor.white],
                                                                     for: .normal)
        }
    }
    
    override var selectedViewController: UIViewController? {
        didSet {
            guard let viewControllers = viewControllers else {
                return
            }
            
            for viewController in viewControllers {
                if viewController == selectedViewController {
                    let selected: [NSAttributedString.Key: AnyObject] = [.font: BrandonGrotesque.bold.of(size: 13)!,
                                                                         .foregroundColor: UIColor.white]
                    viewController.tabBarItem.setTitleTextAttributes(selected, for: .normal)
                } else {
                    let normal: [NSAttributedString.Key: AnyObject] = [.font: BrandonGrotesque.medium.of(size: 13)!,
                                                                       .foregroundColor: UIColor.white]
                    viewController.tabBarItem.setTitleTextAttributes(normal, for: .normal)
                }
            }
        }
    }
    
//    override var traitCollection: UITraitCollection {
//        let realTraits = super.traitCollection
//        let fakeTraits = UITraitCollection(horizontalSizeClass: .regular)
//        return UITraitCollection(traitsFrom: [realTraits, fakeTraits])
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    //MARK: Helper methods
    private func createIngredientsView(viewController: UIViewController) -> UINavigationController {
        //Set Tab Bar Icon for Tap
        let tapImageNormal = UIImage(systemName: "magnifyingglass")
        let tapImageSelected = UIImage(systemName: "magnifyingglass")
        let tapTabBarItem = UITabBarItem(title: "Search", image: tapImageNormal, selectedImage: tapImageSelected)
        
        //Embed Tap controller in Navigation Controller
        let tapNavController = UINavigationController(rootViewController: viewController)
        tapNavController.tabBarItem = tapTabBarItem
        tapNavController.navigationBar.isHidden = true
        
        return tapNavController
    }
    
    private func createReceipesView() -> UINavigationController {
        //Set Tab Bar Icon for Tap
        let receipesImageNormal = UIImage(systemName: "mail.stack")
        let receipesImageSelected = UIImage(systemName: "mail.stack")
        let receipesTabBarItem = UITabBarItem(title: "Recipes",
                                             image: receipesImageNormal, selectedImage: receipesImageSelected)
        
        //Embed Tap controller in Navigation Controller
        let receipesNavController = UINavigationController(rootViewController: ReceipesViewController.instantiate())
        receipesNavController.tabBarItem = receipesTabBarItem
        receipesNavController.navigationBar.isHidden = true
        
        return receipesNavController
    }
    
    private func createCurrentView() -> UINavigationController {
        //Set Tab Bar Icon for Tap
        let currentImageNormal = UIImage(systemName: "newspaper")
        let currentImageSelected = UIImage(systemName: "newspaper")
        let currentTabBarItem = UITabBarItem(title: "Current",
                                              image: currentImageNormal, selectedImage: currentImageSelected)
        
        //Embed Tap controller in Navigation Controller
        let currentNavController = UINavigationController(rootViewController: CurrentViewController.instantiate())
        currentNavController.tabBarItem = currentTabBarItem
        currentNavController.navigationBar.isHidden = true
        
        return currentNavController
    }
    
    private func createSettingView() -> UINavigationController {
        //Set Tab Bar Icon for Tap
        let settingImageNormal = UIImage(systemName: "gearshape.fill")
        let settingImageSelected = UIImage(systemName: "gearshape.fill")
        let settingTabBarItem = UITabBarItem(title: "Settings",
                                              image: settingImageNormal, selectedImage: settingImageSelected)
        
        //Embed Tap controller in Navigation Controller
        let settingsNavController = UINavigationController(rootViewController: SettingsViewController.instantiate())
        settingsNavController.tabBarItem = settingTabBarItem
        settingsNavController.navigationBar.isHidden = true
        
        return settingsNavController
    }
    
    func setupViewControllers() {        
        //Set View Controllers of UITabBarController
        self.setViewControllers([self.createIngredientsView(viewController: IngredientsViewController.instantiate()),
                                 self.createReceipesView(),
                                 self.createCurrentView(),createSettingView()], animated: true)
        self.selectedIndex = 0
    }
}

//MARK: Delegate methods of UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let visibleViewController = self.selectedViewController else { return true }
        return visibleViewController != viewController
    }
}
