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

protocol Coordinator : AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    var presentingController: UIViewController { get set }
    //var uuid: UUID { get }
    
    func start()
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        if !childCoordinators.contains(where: {$0 === coordinator}) {
            childCoordinators.append(coordinator)
        }
    }
    
    func removeChild(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func removeSelf() {
        childCoordinators = []
        parentCoordinator?.removeChild(self)
    }
}
