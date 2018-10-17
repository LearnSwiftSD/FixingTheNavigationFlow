//
//  Storyboarded.swift
//
//  Protocol and default implementation for UIViewController defining a factory initializer for UIStoryboard entities.
//
//  This is based on Paul Hudson's efforts.
//  https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
    static func instantiate(usingID id: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        return instantiate(usingID: className)
    }
    
    static func instantiate(usingID id: String) -> Self {
        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
