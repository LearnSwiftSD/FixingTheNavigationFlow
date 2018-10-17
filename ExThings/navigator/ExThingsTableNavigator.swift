//
//  ExThingsTableNavigator.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-17.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Mediates navigation concerns for ExThingsTableViewController.

import UIKit

class ExThingsTableNavigator: SegueDelegate {
    
    // MARK: - Segue Delegate
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let exThingsTableVC = segue.source as? ExThingsTableViewController,
            let selectedExThing = exThingsTableVC.selectedExThing else { return }
        
        switch selectedExThing {
            
        // Show ExPlace detail view.
        case let selectedExPlace as ExPlace:
            (segue.destination as? ExPlaceConsumer)?.exPlace = selectedExPlace
            
        // Show ExSpecies detail view.
        case let selectedExSpecies as ExSpecies:
            (segue.destination as? ExSpeciesConsumer)?.exSpecies = selectedExSpecies
            
        default :
            break
        }
        
    }
    
}

extension ExThingsTableViewController {
    // Navigation stub for an unwind segue.
    @IBAction func goHome(segue: UIStoryboardSegue) {
        // Nothing needs doing, but it's good to be home.
    }
}
