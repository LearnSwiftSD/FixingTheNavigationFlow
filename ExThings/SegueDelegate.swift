//
//  SegueDelegate.swift
//
//  Protocol for delegates of UIViewController segue interactions.
//  Used by DelegatedSegueViewController, a base class for a UIViewController using this delegation.
//
//  Created by Stephen Downs on 2018-05-07.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

import UIKit

protocol SegueDelegate: AnyObject {
    func shouldPerformSegue(withIdentifier: String, from: UIViewController, withSender: Any?) -> Bool
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    
    func performSegue(withIdentifier identifier: String, from source: UIViewController, withSender sender: Any?)
    
    func allowedChildrenForUnwinding(from source: UIStoryboardUnwindSegueSource, to destination: UIViewController) -> [UIViewController]?
    
    func childViewController(of source: UIViewController, containing segueSource: UIStoryboardUnwindSegueSource) -> UIViewController?
    
    func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, to destination: UIViewController, withSender sender: Any) -> Bool?
    
    func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController, affecting affectedViewController: UIViewController)
}

// Default implementations.
extension SegueDelegate {
    func shouldPerformSegue(withIdentifier identifier: String, from source: UIViewController, withSender sender: Any?) -> Bool {
        return true
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func performSegue(withIdentifier identifier: String, from source: UIViewController, withSender sender: Any?) {
    }
    
    func allowedChildrenForUnwinding(from source: UIStoryboardUnwindSegueSource, to destination: UIViewController) -> [UIViewController]? {
        return nil
    }
    
    func childViewController(of source: UIViewController, containing segueSource: UIStoryboardUnwindSegueSource) -> UIViewController? {
        return nil
    }
    
    func canPerformUnwindSegueAction(_: Selector, from fromViewController: UIViewController, to destination: UIViewController, withSender sender: Any) -> Bool? {
        return nil
    }
    
    func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController, affecting affectedViewController: UIViewController) {
    }
}
