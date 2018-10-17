//
//  SettingsCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-16.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
// Coordinator for SettingsViewController

import UIKit

class SettingsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var presentingController: UIViewController
    
    init(using presentingController: UIViewController) {
        self.presentingController = presentingController
    }
    
    func start() {
        let wrapperNavCon = UINavigationController()
        let settingsVC = SettingsViewController.instantiate()
        settingsVC.delegate = self
        wrapperNavCon.pushViewController(settingsVC, animated: false)
        // Present the settings VC and wrapping navigation controller modally.
        presentingController.content.present(wrapperNavCon, animated: true, completion: nil)
    }
}

extension SettingsCoordinator: SettingsViewControllerDelegate {
    func removed(_ settingsViewController: SettingsViewController) {
        removeSelf()
    }
}
