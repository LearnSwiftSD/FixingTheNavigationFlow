//
//  NoteEditorCoordinator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-17.
//  Copyright © 2018 plasticbrain. All rights reserved.
//
// Coordinator for NoteEditorViewController

import UIKit

class NoteEditorCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var text: String?
    var presentingController: UIViewController
    
    init(using presentingController: UIViewController, text: String? = nil) {
        self.presentingController = presentingController
        self.text = text
    }
    
    func start() {
        let wrapperNavCon = UINavigationController()
        let noteVC = NoteEditorViewController.instantiate()
        noteVC.text = text
        noteVC.delegate = self
        wrapperNavCon.pushViewController(noteVC, animated: false)
        // Present the note VC and wrapping navigation controller modally.
        presentingController.content.present(wrapperNavCon, animated: true, completion: nil)
    }
}

extension NoteEditorCoordinator: NoteEditorViewControllerDelegate {
    func removed(_ noteEditorViewController: NoteEditorViewController) {
        removeSelf()
    }
}
