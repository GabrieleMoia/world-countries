//
//  AppDelegate.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 17/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var homeCoordinator: HomeCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Theme
        AppTheme().applyTheme()
        
        let navController = UINavigationController()

        self.homeCoordinator = HomeCoordinator(navigationController: navController)
        self.homeCoordinator?.start()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

