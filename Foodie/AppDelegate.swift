//
//  AppDelegate.swift
//  Foodie
//
//  Created by Aaqib Seliya on 09/12/2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        configureUIAppearance()
        configureNavigationBarAppearance()
        initializeAppSettingsAndShowScreen()
        configureTabBarAppearance()
        return true
    }
    
    func configureUIAppearance() {
        //Set Translucent of UINavigationBar and UITabBar
        UINavigationBar.appearance().isTranslucent = false
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .white
        
        //Title Adjustment
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        UITabBarItem.appearance().setTitleTextAttributes([.font: BrandonGrotesque.medium.of(size: 13)!,
                                                          .foregroundColor: UIColor.red], for: .normal)
        UITabBar.appearance().clipsToBounds = true
    }
    
    func configureTabBarAppearance() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()
            
            tabBarItemAppearance.normal.titleTextAttributes = [.font: BrandonGrotesque.bold.of(size: 13)!,
                                                               NSAttributedString.Key.foregroundColor: UIColor.gray]
            tabBarItemAppearance.selected.titleTextAttributes = [.font: BrandonGrotesque.bold.of(size: 13)!,
                                                                 NSAttributedString.Key.foregroundColor: UIColor.white]
            
            appearance.stackedLayoutAppearance = tabBarItemAppearance
            
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .black
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().unselectedItemTintColor = .white
        }
    }
    
    func configureNavigationBarAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    func initializeAppSettingsAndShowScreen() {
        if Auth.auth().currentUser == nil {
            self.showLoginView()
        } else {
            self.showMainView()
        }
    }
    
    func showLoginView() {
        //Initialize the Window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //Initialize the Welcome View Controller
        let navVC = UINavigationController(rootViewController: LoginViewController.instantiate())
        navVC.navigationBar.isHidden = true
        
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }
    
    func showMainView() {
        //Initialize the Window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //Initialize the Tab Bar Controller
        let tabBarController = TabBarController()
        tabBarController.setupViewControllers()
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
}

