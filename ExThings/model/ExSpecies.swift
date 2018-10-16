//
//  ExSpecies.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Value data object describing an extinct species.
// kludge: "species" is both singular and plural, so it's a poor naming choice! Oh well.

import Foundation

struct ExSpecies: ExThing, Codable, Hashable {
    // A non-scientific general class taxonomy.
    enum GeneralClass: String, Codable {
        case bird, mammal, reptile
        
        func stringPlural() -> String {
            return "\(self)s"
        }
    }
    
    var commonName: String
    var description: String
    
    // This really should be stored as a range. Perhaps a tuple:
    //var extinctionDate: (from: Date, to: Date)
    // For simplicity in this implementation, a single Date is used.
    var extinctionDate: Date
    
    var generalClass: ExSpecies.GeneralClass
    var habitat: [NamedPlace] = []
    
    var image: String?
    
    // Optional user notes.
    var notes: String?
    
    var scientificName: String
    
    // Unique ID for this object.
    var uuid: UUID
}

protocol ExSpeciesConsumer: AnyObject {
    var exSpecies: ExSpecies? { get set }
}
