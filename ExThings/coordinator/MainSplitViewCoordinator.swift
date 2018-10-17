//
//  MainSplitViewCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-16.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
//  Main Coordinator for app when using a root UISplitViewController.

import UIKit

class MainSplitViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var presentingController: UIViewController
    
    init(using presentingController: UIViewController) {
        self.presentingController = presentingController
    }
    
    func start() {
        // todo
    }
}
