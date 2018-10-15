//
//  Preferences.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-15.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// App configuration settings.

import Foundation

class Preferences {
    
    enum Container: String {
        case navigationController, splitViewController, tabBarController
        static let defaultContainer = Container.navigationController
        static let key = "container"
        
        func asStoryboardID() -> String {
            switch self {
            case .navigationController:
                return "rootNavigationController"
            case .splitViewController:
                return "rootSplitViewController"
            case .tabBarController:
                return "rootTabBarController"
            }
        }
        
    }
    
    static private var settings = UserDefaults.standard
    
    static var container: Container {
        get {
            if let containerValue = settings.string(forKey: Container.key) {
                return Container(rawValue: containerValue) ?? Container.defaultContainer
            } else {
                settings.set(Container.defaultContainer.rawValue, forKey: Container.key)
                return Container.defaultContainer
            }
        }
        set {
            settings.set(newValue.rawValue, forKey: Container.key)
        }
    }
    
}
