//
//  ExPlaceDetailInTabBarViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-09.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// A special ExPlaceDetailViewController contained in a Tab Bar.
// In the parent ExPlaceDetailViewController, there is a "show nearest ExSpecies" button that triggers a storyboard show segue. In this variation, this view controller is embedded in a navigation stack managed by a tab bar. The "show nearest species" button in this context has an increased decision tree to perform its navigation action that can't be expressed by a simple storyboard segue, but is instead encapsulated in the custom selectExSpecies function below.
//
// Note: This is not ideal interface design! Tab Bar layout should be used for different exclusive app modes. It is being abused here as a sort of navigation/organization paradigm.

import UIKit

class ExPlaceDetailInTabBarViewController: ExPlaceDetailViewController {
    
    // MARK: - Interaction
    
    // An ExSpecies has been selected. Show details for it.
    // This performs a tricky navigation action to first select the species tab, then performs the show navigation.
    @IBAction func selectExSpecies(_ sender: UIButton) {
        // The source view controller from which the navigation should take place.
        var sourceViewController: UIViewController?
        // Select the appropriate tab in the governing Tab Bar Controller.
        if let tabBarController = tabBarController {
            // kludge - Ouch, hard coding. That hurts!
            tabBarController.selectedIndex = 1
            // kludge - Find the fall guy to perform the navigation dirty work, the source view controller.
            // It can be found by looking at the view displayed in the wrapping navigation controller found inside the governing tab bar controller's view stack. That is a lot of placement assumption!
            sourceViewController = (tabBarController.selectedViewController as? UINavigationController)?.visibleViewController
        }
        // Navigate to display the selected ExSpecies.
        // In this demonstration project, the storyboard is overloaded just to show multiple contexts in which the same view controllers can be presented. Two separate ExSpeciesDetailViewController scenes are needed because they are hardwired to different sets of storyboard segues (namely the goHome action triggered by the unwind segue).
        // So there are two different ExSpeciesDetailViewController scenes on the storyboard. Both can share the same class, but they use different storyboard reference IDs ("exSpeciesDetailViewController" and "exSpeciesDetailInTabBarViewController"). We want to use "exSpeciesDetailInTabBarViewController" here.
        if let exSpeciesDetailViewController = storyboard?.instantiateViewController(withIdentifier: "exSpeciesDetailInTabBarViewController") as? ExSpeciesDetailViewController,
            let sourceViewController = sourceViewController {
            exSpeciesDetailViewController.exSpecies = nearestExSpecies
            if let existingSpeciesDetailViewController = sourceViewController as? ExSpeciesDetailViewController,
                existingSpeciesDetailViewController.exSpecies == nearestExSpecies {
                // An ExSpeciesDetailViewController instance is already present on the view controller stack managed by the Species tab, and it is already presenting this ExSpecies.
                // Do nothing!
                return
            } else {
                // The requested ExSpecies details are not currently being shown.
                // Present as a new ExSpeciesDetailViewController pushed on the stack.
                sourceViewController.show(exSpeciesDetailViewController, sender: sender)
            }
        }
    }
    
}
