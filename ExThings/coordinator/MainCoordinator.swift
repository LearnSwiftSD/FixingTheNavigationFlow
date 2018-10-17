//
//  MainCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-16.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
//  Main point of entry Coordinator.

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func start() {
        // todo
    }
}
