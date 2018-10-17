//
//  MainNavigationCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-16.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
//  Main Coordinator for app when using a root UINavigationController.

import UIKit

class MainNavigationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var presentingController: UIViewController
    
    init(using window: UIWindow?) {
        presentingController = ExThingsNavigationController.instantiate(usingID: "rootNavigationController")
        window?.rootViewController = presentingController
    }
    
    func start() {
        let exThingsTableCoordinator = ExThingsTableCoordinator(using: presentingController)
        addChild(exThingsTableCoordinator)
        exThingsTableCoordinator.start()
    }
}
