//
//  ExThingsTableCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-16.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
// Coordinator for ExThingsTableViewController

import UIKit

class ExThingsTableCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var presentingController: UIViewController
    
    var navVC: UINavigationController? {
        get {
            return presentingController as? UINavigationController
        }
    }
    
    init(using presentingController: UIViewController) {
        self.presentingController = presentingController
    }
    
    func start() {
        let exThingsTableVC = ExThingsTableViewController.instantiate()
        exThingsTableVC.delegate = self
        navVC?.pushViewController(exThingsTableVC, animated: false)
    }
}

extension ExThingsTableCoordinator: ExThingsTableViewControllerDelegate {
    
    func didSelectSettings(_ exThingsTableViewController: ExThingsTableViewController) {
        let settingsCoordinator = SettingsCoordinator(using: presentingController)
        addChild(settingsCoordinator)
        settingsCoordinator.start()
    }
    
    func exThingsTableViewController(_ exThingsTableViewController: ExThingsTableViewController, didSelectExThing exThing: ExThing) {
        switch exThing {
            
        case let exPlace as ExPlace:
            let exPlaceDetailCoordinator = ExPlaceDetailCoordinator(using: presentingController, exPlace: exPlace)
            addChild(exPlaceDetailCoordinator)
            exPlaceDetailCoordinator.start()
            
        case let exSpecies as ExSpecies:
            let exSpeciesDetailCoordinator = ExSpeciesDetailCoordinator(using: presentingController, exSpecies: exSpecies)
            addChild(exSpeciesDetailCoordinator)
            exSpeciesDetailCoordinator.start()
            
        default:
            break
        }
    }
    
    func removed(_ exThingsTableViewController: ExThingsTableViewController) {
        removeSelf()
    }
    
}
