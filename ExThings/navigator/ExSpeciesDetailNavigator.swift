//
//  ExSpeciesDetailNavigator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-17.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Mediates navigation concerns for an ExSpeciesDetailViewController.

import UIKit

class ExSpeciesDetailNavigator: Navigator, SegueDelegate {
    
    enum Destination {
        case exSpeciesView(exSpecies: ExSpecies)
    }
    
    // MARK: - Navigator
    
    func navigate(to destination: Destination, from source: UIViewController) {
        switch destination {
            
        case .exSpeciesView(let exSpecies):
            if let relatedExSpeciesDetailVC = source.storyboard?.instantiateViewController(withIdentifier: "exSpeciesDetailViewController") {
                if let speciesConsumer = relatedExSpeciesDetailVC as? ExSpeciesConsumer {
                    speciesConsumer.exSpecies = exSpecies
                }
                source.content.show(relatedExSpeciesDetailVC, sender: source)
            }
            
        }
        
    }
    
    // MARK: - Segue Delegate
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {

        // Show map.
        case "showMap":
            if let destinationVC = segue.destination.content as? AnnotatedPlaceConsumer,
                let habitat = (segue.source as? ExSpeciesDetailViewController)?.exSpecies?.habitat[0] {
                destinationVC.annotatedPlace = habitat
            }

        // Show note editor.
        case "showNote":
            (segue.destination.content as? TextConsumer)?.text = (segue.source as? ExSpeciesDetailViewController)?.exSpecies?.notes

        default:
            break

        }
    }
    
}

// MARK: - Additional Navigation

extension ExSpeciesDetailViewController {
    @IBAction func selectSaveNote(segue: UIStoryboardSegue) {
        if let noteEditorVC = segue.source.content as? NoteEditorViewController,
            exSpecies != nil
        {
            exSpecies!.notes = noteEditorVC.text
            exSpeciesService.save(exSpecies!)
            updateViewFromData()
        }
    }
}
