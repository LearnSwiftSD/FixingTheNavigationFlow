//
//  ExThing.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-07.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

import Foundation

protocol ExThing: CustomStringConvertible {
    var description: String { get set }
    var extinctionDate: Date { get set }
    
    func extinctionDateAsString() -> String
}

// Default implementations.
extension ExThing {
    // Default implementation returns the extinction date as a year string with "yyyy" format.
    func extinctionDateAsString() -> String {
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        yearFormatter.locale = Locale(identifier: "en_US")
        return yearFormatter.string(from: extinctionDate)
    }
}

protocol ExThingConsumer: AnyObject {
    var exThing: ExThing? { get set }
}
