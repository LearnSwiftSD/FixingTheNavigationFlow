//
//  ExPlaceDetailCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-16.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
// Coordinator for ExPlaceDetailViewController

import UIKit

class ExPlaceDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var exPlace: ExPlace?
    
    var presentingController: UIViewController
    var navCon: UINavigationController? {
        get {
            return presentingController as? UINavigationController
        }
    }
    
    init(using presentingController: UIViewController, exPlace: ExPlace) {
        self.presentingController = presentingController
        self.exPlace = exPlace
    }
    
    func start() {
        let exPlaceDetailVC = ExPlaceDetailViewController.instantiate()
        exPlaceDetailVC.exPlace = exPlace
        exPlaceDetailVC.delegate = self
        navCon?.pushViewController(exPlaceDetailVC, animated: true)
    }
}

extension ExPlaceDetailCoordinator: ExPlaceDetailViewControllerDelegate {
    
    func didSelectAddNote(_ exPlaceDetailViewController: ExPlaceDetailViewController, text: String?) {
        let noteCoordinator = NoteEditorCoordinator(using: presentingController, text: text)
        addChild(noteCoordinator)
        noteCoordinator.start()
    }
    
    func didSelectHome(_ exPlaceDetailViewController: ExPlaceDetailViewController) {
        navCon?.popToRootViewController(animated: true)
    }
    
    func didSelectMap(_ exPlaceDetailViewController: ExPlaceDetailViewController, place: AnnotatedPlace) {
        let mapCoordinator = MapCoordinator(using: presentingController, place: place)
        addChild(mapCoordinator)
        mapCoordinator.start()
    }
    
    func didSelectNearestPlace(_ exPlaceDetailViewController: ExPlaceDetailViewController, exPlace: ExPlace) {
        let exPlaceDetailCoordinator = ExPlaceDetailCoordinator(using: presentingController, exPlace: exPlace)
        addChild(exPlaceDetailCoordinator)
        exPlaceDetailCoordinator.start()
    }
    
    func didSelectNearestSpecies(_ exPlaceDetailViewController: ExPlaceDetailViewController, exSpecies: ExSpecies) {
        let exSpeciesDetailCoordinator = ExSpeciesDetailCoordinator(using: presentingController, exSpecies: exSpecies)
        addChild(exSpeciesDetailCoordinator)
        exSpeciesDetailCoordinator.start()
    }
    
    func removed(_ exPlaceDetailViewController: ExPlaceDetailViewController) {
        removeSelf()
    }
    
}
