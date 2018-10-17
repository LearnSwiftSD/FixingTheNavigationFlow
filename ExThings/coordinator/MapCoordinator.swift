//
//  MapCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-17.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
// Coordinator for MapViewController

import UIKit

class MapCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var place: AnnotatedPlace?
    var presentingController: UIViewController
    
    init(using presentingController: UIViewController, place: AnnotatedPlace) {
        self.presentingController = presentingController
        self.place = place
    }
    
    func start() {
        let wrapperNavCon = UINavigationController()
        let mapVC = MapViewController.instantiate()
        mapVC.annotatedPlace = place
        mapVC.delegate = self
        wrapperNavCon.pushViewController(mapVC, animated: false)
        // Present the map VC and wrapping navigation controller modally.
        presentingController.content.present(wrapperNavCon, animated: true, completion: nil)
    }
}

extension MapCoordinator: MapViewControllerDelegate {
    func removed(_ mapViewController: MapViewController) {
        removeSelf()
    }
}
