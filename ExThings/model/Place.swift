//
//  Place.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Protocol for an object describing a place.

import Foundation

protocol Place: Codable {
    var location: Location { get set }
}

enum Location: Hashable {
    case point(latitude: Double, longitude: Double)
    //case region
}

extension Location: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let locationPoints = try? container.decode(Array<Double>.self, forKey: .point), locationPoints.count == 2 {
            self = .point(latitude: locationPoints[0], longitude: locationPoints[1])
            return
        }
        
        throw DecodingError.keyNotFound(CodingKeys.point, DecodingError.Context(codingPath: [CodingKeys.point], debugDescription: "Failed decoding Location"))
    }
}

extension Location: Encodable {
    enum CodingKeys: CodingKey {
        case point
        //case region
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .point(let latitude, let longitude):
            try container.encode([latitude, longitude], forKey: .point)
        }
    }
}
