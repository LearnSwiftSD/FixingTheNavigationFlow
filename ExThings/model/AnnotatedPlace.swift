//
//  AnnotatedPlace.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-08.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Protocol describing a named location.

import Foundation

protocol AnnotatedPlace: Place {
    var name: String { get set }
    var subtitle: String? { get set }
}
