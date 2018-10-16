//
//  TextConsumer.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-15.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Data consumer protocol defining an object that uses text (String optional).

import Foundation

protocol TextConsumer: AnyObject {
    var text: String? { get set }
}
