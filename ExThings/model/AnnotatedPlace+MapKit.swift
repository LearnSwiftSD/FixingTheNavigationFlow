//
//  AnnotatedPlace+MapKit.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-08.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

import Foundation
import MapKit

extension AnnotatedPlace {
    func asMKPointAnnotation() -> MKAnnotation? {
        guard let coordinate = self.coordinate else { return nil }
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = self.name
        annotation.subtitle = self.subtitle
        return annotation
    }
    
    func asMKMapPoint() -> MKMapPoint? {
        guard let coordinate = self.coordinate else { return nil }
        return MKMapPoint(coordinate)
    }
    
    func distance(to place: AnnotatedPlace) -> Double? {
        if let point1 = self.asMKMapPoint(), let point2 = place.asMKMapPoint() {
            return point1.distance(to: point2)
        } else {
            return nil
        }
    }
}
