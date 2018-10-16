//
//  ExThingsSplitViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-09.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Root container view for ExThings application presented in an adaptive split view.

import UIKit

class ExThingsSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    private var secondaryViewControllerShouldCollapse = true
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredDisplayMode = .allVisible
        self.delegate = self
    }
    
    // MARK: - Navigation
    
    @IBAction func subviewWillAppear(segue: UIStoryboardSegue) {
        if let exThing = (segue.source as? ExThingConsumer)?.exThing {
            updatePrimaryViewSelection(to: exThing)
        }
    }
    
    // MARK: - Rendering

    // Upon first access in a horizontally compact environment, ensure that the primary view is the display view.
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        let collapseSecondaryVC = secondaryViewControllerShouldCollapse
        secondaryViewControllerShouldCollapse = false
        return collapseSecondaryVC
    }
    
    private func updatePrimaryViewSelection(to exThing: ExThing) {
        // This code does not trigger when in a split view in a horizontally compact environment, since the master view (exThingsTableViewController) is not present.
        if viewControllers.count > 1,
            let exThingsVC = viewControllers[0].content as? ExThingConsumer {
            exThingsVC.exThing = exThing
        }
    }
    
}

// MARK: - ExThingsTableViewController navigation

extension ExThingsTableViewController: ExThingConsumer {
    
    var exThing: ExThing? {
        get {
            // Not part of the implementation here.
            return nil
        }
        set {
            if let newExThing = newValue {
                selectExThing(newExThing)
            }
        }
    }
    
    // Select requested ExThing in table view and scroll to show it.
    func selectExThing(_ thing: ExThing) {
        switch thing {
            
        // Select an ExPlace.
        case let exPlace as ExPlace:
            if let row = exPlaces.firstIndex(of: exPlace) {
                tableView.selectRow(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .top)
            }
            
        // Select an ExSpecies.
        case let exSpecies as ExSpecies:
            // self.exSpecies is the data array of ExSpecies.
            if let row = self.exSpecies.firstIndex(of: exSpecies) {
                tableView.selectRow(at: IndexPath(row: row, section: 1), animated: true, scrollPosition: .top)
            }
            
        default:
            break
        }
    }
}
