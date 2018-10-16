//
//  ExPlace.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Value data object representing an abandoned place.

import Foundation

struct ExPlace: ExThing, AnnotatedPlace, Codable, Hashable {
    var name: String
    var subtitle: String?
    var description: String
    
    // This really should be stored as a range. Perhaps a tuple:
    //var extinctionDate: (from: Date, to: Date)
    // For simplicity in this implementation, a single Date is used.
    var extinctionDate: Date
    
    var image: String?
    var location: Location
    
    // Optional user notes.
    var notes: String?
    
    // Unique ID for this object.
    var uuid: UUID
}

protocol ExPlaceConsumer: AnyObject {
    var exPlace: ExPlace? { get set }
}
