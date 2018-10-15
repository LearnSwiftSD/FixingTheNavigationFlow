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
    
    // MARK: - Rendering

    // Upon first access in a horizontally compact environment, ensure that the primary view is the display view.
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        let collapseSecondaryVC = secondaryViewControllerShouldCollapse
        secondaryViewControllerShouldCollapse = false
        return collapseSecondaryVC
    }
}
