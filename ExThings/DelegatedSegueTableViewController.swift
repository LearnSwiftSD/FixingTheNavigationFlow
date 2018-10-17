//
//  DelegatedSegueTableViewController.swift
//
//  Created by Stephen Downs on 2018-10-17.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

import UIKit

class DelegatedSegueTableViewController: UITableViewController {
    
    var segueDelegate: SegueDelegate?
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return segueDelegate?.shouldPerformSegue(withIdentifier: identifier, from: self, withSender: sender) ??
            super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
    }
    
    // Notifies the delegate that a segue is about to be performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueDelegate?.prepare(for: segue, sender: sender)
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        // Inform segue delegate that performSegue was called.
        segueDelegate?.performSegue(withIdentifier: identifier, from: self, withSender: sender)
        // Perform the segue, if allowed.
        if shouldPerformSegue(withIdentifier: identifier, sender: sender) {
            super.performSegue(withIdentifier: identifier, sender: sender)
        }
    }
    
    override func allowedChildrenForUnwinding(from source: UIStoryboardUnwindSegueSource) -> [UIViewController] {
        return segueDelegate?.allowedChildrenForUnwinding(from: source, to: self) ??
            super.allowedChildrenForUnwinding(from: source)
    }
    
    // Returns the child view controller that contains the source of the unwind segue.
    override func childContaining(_ source: UIStoryboardUnwindSegueSource) -> UIViewController? {
        return segueDelegate?.childViewController(of: self, containing: source) ?? super.childContaining(source)
    }
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
        return segueDelegate?.canPerformUnwindSegueAction(action, from: fromViewController, to: self, withSender: sender) ?? super.canPerformUnwindSegueAction(action, from: fromViewController, withSender: sender)
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        segueDelegate?.unwind(for: unwindSegue, towards: subsequentVC, affecting: self)
    }
    
    deinit {
        segueDelegate = nil
    }
    
}
