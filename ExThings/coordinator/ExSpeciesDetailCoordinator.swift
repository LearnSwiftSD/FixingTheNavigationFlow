//
//  ExSpeciesDetailCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-17.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
// Coordinator for ExSpeciesDetailViewController

import UIKit

class ExSpeciesDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var exSpecies: ExSpecies?
    
    var presentingController: UIViewController
    var navCon: UINavigationController? {
        get {
            return presentingController as? UINavigationController
        }
    }
    
    init(using presentingController: UIViewController, exSpecies: ExSpecies) {
        self.presentingController = presentingController
        self.exSpecies = exSpecies
    }
    
    func start() {
        let exSpeciesDetailVC = ExSpeciesDetailViewController.instantiate(usingID: "exSpeciesDetailViewController")
        exSpeciesDetailVC.exSpecies = exSpecies
        exSpeciesDetailVC.delegate = self
        navCon?.pushViewController(exSpeciesDetailVC, animated: true)
    }
}

extension ExSpeciesDetailCoordinator: ExSpeciesDetailViewControllerDelegate {
    
    func didSelectAddNote(_ exSpeciesDetailViewController: ExSpeciesDetailViewController, text: String?) {
        let noteCoordinator = NoteEditorCoordinator(using: presentingController, text: text)
        addChild(noteCoordinator)
        noteCoordinator.start()
    }
    
    func didSelectHome(_ exSpeciesDetailViewController: ExSpeciesDetailViewController) {
        navCon?.popToRootViewController(animated: true)
    }
    
    func didSelectMap(_ exSpeciesDetailViewController: ExSpeciesDetailViewController, place: AnnotatedPlace) {
        let mapCoordinator = MapCoordinator(using: presentingController, place: place)
        addChild(mapCoordinator)
        mapCoordinator.start()
    }
    
    func didSelectSpecies(_ exSpeciesDetailViewController: ExSpeciesDetailViewController, exSpecies: ExSpecies) {
        let exSpeciesDetailCoordinator = ExSpeciesDetailCoordinator(using: presentingController, exSpecies: exSpecies)
        addChild(exSpeciesDetailCoordinator)
        exSpeciesDetailCoordinator.start()
    }
    
    func removed(_ exSpeciesDetailViewController: ExSpeciesDetailViewController) {
        removeSelf()
    }
    
}
