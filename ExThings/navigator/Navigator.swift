//
//  Navigator.swift
//
//  Protocol for defining and handling navigation towards a destination.
//  The navigator covers creation and presentation concerns for a particular navigation destination.
//
//  Based on a pattern proposed by John Sundell
//  https://www.swiftbysundell.com/posts/navigation-in-swift?rq=Navigator
//

import UIKit

protocol Navigator {
    associatedtype Destination

    func navigate(to destination: Destination, from source: UIViewController)
}
