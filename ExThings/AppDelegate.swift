//
//  AppDelegate.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: Coordinator?

    var window: UIWindow?
    
    // MARK: - Model - Data services
    
    lazy var exPlacesService = ExPlacesService()
    lazy var exSpeciesService = ExSpeciesService()

    // MARK: - Lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // There are three user-selectable navigation container paradigms for this application.
        // Set the root view controller to the chosen navigation container.
//        let sb = UIStoryboard.init(name: "Main", bundle: nil)
//        let rootVC = sb.instantiateViewController(withIdentifier: Preferences.container.asStoryboardID())
        
        // Create a basic UIWindow and activate it.
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        // Pass the root view controller to the main coordinator.
        //coordinator = MainCoordinator(using: rootVC)
        
        switch Preferences.container {
        case .navigationController:
            coordinator = MainNavigationCoordinator(using: window)
        case .splitViewController:
            // todo
            //coordinator = MainSplitViewCoordinator(using: rootVC)
            // for now
            coordinator = MainNavigationCoordinator(using: window)
        case .tabBarController:
            // todo
           // coordinator = MainTabBarCoordinator(using: rootVC)
            // for now
            coordinator = MainNavigationCoordinator(using: window)
        }
        
        // Bless the point of entry and start the application flow.
        coordinator?.start()
        
        return true
    }

}
