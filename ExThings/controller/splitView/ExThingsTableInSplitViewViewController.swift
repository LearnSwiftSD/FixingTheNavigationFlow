//
//  ExThingsTableInSplitViewViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-10.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// An ExThingsTableViewController in a split view controller container.

import UIKit

class ExThingsTableInSplitViewViewController: ExThingsTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Show ExPlace detail view.
        if segue.identifier == "showExPlaceDetail",
            let secondaryNavVC = segue.destination as? UINavigationController,
            let exPlaceDetailVC = secondaryNavVC.visibleViewController as? ExPlaceDetailInSplitViewViewController,
            let selectedIndex = tableView.indexPathForSelectedRow,
            selectedIndex.section == 0
        {
            let selectedExPlace = exPlaces[selectedIndex.row]
            exPlaceDetailVC.exPlace = selectedExPlace
        }
        
        // Show ExSpecies detail view.
        if segue.identifier == "showExSpeciesDetail",
            let secondaryNavVC = segue.destination as? UINavigationController,
            let exSpeciesDetailVC = secondaryNavVC.visibleViewController as? ExSpeciesDetailInSplitViewViewController,
            let selectedIndex = tableView.indexPathForSelectedRow,
            selectedIndex.section == 1
        {
            let selectedExSpecies = exSpecies[selectedIndex.row]
            exSpeciesDetailVC.exSpecies = selectedExSpecies
        }
        
    }
    
}
