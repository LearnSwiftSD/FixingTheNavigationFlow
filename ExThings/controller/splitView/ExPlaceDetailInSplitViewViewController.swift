//
//  ExPlaceDetailInSplitViewViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-10.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// An ExPlaceDetailViewController within a split view controller container.

import UIKit

class ExPlaceDetailInSplitViewViewController: ExPlaceDetailViewController {
    
    @IBOutlet weak var homeButton: UIBarButtonItem!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigationBar(of: navigationController)
        updateHomeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updatePrimaryVC()
        updateNavigationBar(of: navigationController)
    }
    
    // todo - updateHomeButton needs to be called on orientation change, since this can change the horizontal trait from compact to regular (requiring Home button to be again hidden).
    
    // MARK: - Rendering
    
    private func updateHomeButton() {
        if let splitViewCount = splitViewController?.viewControllers.count,
            splitViewCount > 1 {
            // This is inside of a split view controller in a horizontally regular environment.
            // Hide the Home button.
            homeButton?.tintColor = .clear
            homeButton?.isEnabled = false
        }
    }
    
    // In a split view in a horizontally compact environment, with the nested navigation controllers present in the show detail segues in the storyboard, there is a condition where navigation controllers can become nested!
    // This ensures that all navigation bar titles are appropriately set.
    private func updateNavigationBar(of navController: UINavigationController?) {
        if let nc = navController {
            nc.navigationBar.prefersLargeTitles = false
            // Recursively set the navigation bar of the navigation controller of this navigation controller.
            updateNavigationBar(of: nc.navigationController)
        }
    }
    
    // Update the selected ExPlace in the primary view table.
    private func updatePrimaryVC() {
        // This code does not trigger when in a split view in a horizontally compact environment, since the master view (exThingsTableViewController) is not present.
        if let primaryViewNavigationController = splitViewController?.viewControllers[0] as? UINavigationController,
            let exThingsTableViewController = primaryViewNavigationController.visibleViewController as? ExThingsTableViewController,
            let exPlace = exPlace {
            exThingsTableViewController.selectExThing(exPlace)
        }
    }
    
}
