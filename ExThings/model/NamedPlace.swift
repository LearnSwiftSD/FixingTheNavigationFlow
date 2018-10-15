//
//  NamedPlace.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Value data object representing a named place.

import Foundation

struct NamedPlace: AnnotatedPlace, Codable, Hashable {
    var name: String
    var subtitle: String?
    var location: Location
}
