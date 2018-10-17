//
//  Coordinator.swift
//
//  Protocol defining base Coordinator implementation.
//
//  Based on a design pattern defined by Soroush Khanlou.
//  http://khanlou.com/2015/01/the-coordinator/
//  http://khanlou.com/2015/10/coordinators-redux/
//
//  This implementation is based on Paul Hudson's efforts.
//  https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var viewController: UIViewController { get set }
    
    func start()
}
