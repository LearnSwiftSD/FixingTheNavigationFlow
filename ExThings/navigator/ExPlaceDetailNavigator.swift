//
//  ExPlaceDetailNavigator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-16.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Mediates navigation concerns for an ExPlaceDetailViewController.

import UIKit

class ExPlaceDetailNavigator: SegueDelegate {
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        // Show ExPlace detail view.
        case "showExPlaceDetail":
            (segue.destination.content as? ExPlaceConsumer)?.exPlace = (segue.source.content as? ExPlaceDetailViewController)?.nearestExPlace
            
        // Show ExSpecies detail view.
        case "showExSpeciesDetail":
            (segue.destination.content as? ExSpeciesConsumer)?.exSpecies = (segue.source.content as? ExPlaceDetailViewController)?.nearestExSpecies
            
        // Show map view.
        case "showMap":
            (segue.destination.content as? AnnotatedPlaceConsumer)?.annotatedPlace = (segue.source.content as? ExPlaceDetailViewController)?.nearestExPlace
            
        // Show note editor.
        case "showNote":
            (segue.destination.content as? TextConsumer)?.text = (segue.source.content as? ExPlaceDetailViewController)?.exPlace?.notes
            
        default:
            break
        }
    }
    
}

extension ExPlaceDetailViewController {
    @IBAction func selectSaveNote(segue: UIStoryboardSegue) {
        if let noteEditor = segue.source as? TextConsumer,
            exPlace != nil
        {
            exPlace!.notes = noteEditor.text
            exPlacesService.save(exPlace!)
        }
    }
}
