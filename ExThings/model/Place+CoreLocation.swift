//
//  Place+CoreLocation.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Convenience calculated properties for Place when working with Core Location.

import Foundation
import CoreLocation

extension Place {
    var coordinate: CLLocationCoordinate2D? {
        get {
            switch location {
            case let .point(latitude, longitude):
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            case .region:
//                return nil
            }
        }
        set {
            guard let newCoordinate = newValue else { return }
            location = .point(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
        }
    }
}
