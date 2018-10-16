//
//  ExThingsTabBarController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-15.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Root container view for ExThings application presented in a tab bar.
// This is a technical demonstration, but from a user interface standpoint it is not a good idea to use tab bars to arbitrarily split data like this. Tab bar UI should be used for presenting distinct modes of an app.

import UIKit

class ExThingsTabBarController: UITabBarController {

    // MARK: - Navigation
    
    @IBAction func showExSpecies(segue: UIStoryboardSegue) {
        guard let exSpecies = (segue.source as? ExSpeciesConsumer)?.exSpecies else { return }
        
        // Select the Species tab.
        selectedIndex = 1
        
        // In this demonstration project, the storyboard is overloaded just to show multiple contexts in which the same view controllers can be presented. Two separate ExSpeciesDetailViewController scenes are needed because they are hardwired to different sets of storyboard segues.
        // So there are two different ExSpeciesDetailViewController scenes on the storyboard. Both can share the same class, but they use different storyboard reference IDs ("exSpeciesDetailViewController" and "exSpeciesDetailInTabBarViewController"). We want to use "exSpeciesDetailInTabBarViewController" here.
        if let exSpeciesVC = storyboard?.instantiateViewController(withIdentifier: "exSpeciesDetailInTabBarViewController") {
            
            if let exSpeciesConsumer = exSpeciesVC as? ExSpeciesConsumer {
                exSpeciesConsumer.exSpecies = exSpecies
            }
        
            self.content.show(exSpeciesVC, sender: self)
        }
    }

}
