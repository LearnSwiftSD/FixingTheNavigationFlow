//
//  ViewControllerUtilities.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-15.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Convenience utilities for working with UIViewController classes.

import UIKit

extension UIViewController {
    
    // Return the view controller governing the focused content of this view controller.
    var content: UIViewController {
        
        switch self {
            
        case let navigationController as UINavigationController:
            return navigationController.visibleViewController?.content ?? navigationController
            
        case let splitViewController as UISplitViewController:
            return splitViewController.viewControllers.last?.content ?? splitViewController
            
        case let tabBarController as UITabBarController:
            return tabBarController.selectedViewController?.content ?? tabBarController
            
        default:
            return self
        }
    }
    
}
