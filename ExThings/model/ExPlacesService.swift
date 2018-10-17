//
//  ExPlacesService.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// A volatile data service for authoritative ExPlaces data.
// There is no data persistence from session to session.

import Foundation

class ExPlacesService {
    
    // kludge: Add a few days time to Date calculations to counter leap year cutoff offsets that would push year back by 1.
    // These calculated dates are all Jan 1 values. The year is the significant value here.
    private let bufferTime = 100_000.0
    
    private let secondsInAYear = 31_557_600.0
    private let referenceYear = 2001
    
    lazy var exPlaces: Array<ExPlace> = {
        
        var xYear = Double(2005 - referenceYear)
        let xp1 = ExPlace(
            name: "Six Flags, New Orleans",
            subtitle: "",
            description: "An amusement park destroyed by floods from Hurricane Katrina.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_sixflags",
            location: Location.point(latitude: 30.0531, longitude: -89.9340),
            notes: nil,
            uuid: UUID()
        )
        
        xYear = Double(1986 - referenceYear)
        let xp2 = ExPlace(
            name: "Pripyat",
            subtitle: "",
            description: "Ukrainian city abandoned after widespread nuclear contamination.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_pripyat",
            location: Location.point(latitude: 51.4045, longitude: 30.0542),
            notes: nil,
            uuid: UUID()
        )
        
        xYear = Double(1999 - referenceYear)
        let xp3 = ExPlace(
            name: "Silver Mine, Leadville, CO",
            subtitle: "",
            description: "An abandoned mine contaminated with lead and arsenic.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_silvermineleadville",
            location: Location.point(latitude: 39.2480, longitude: -106.2593),
            notes: nil,
            uuid: UUID()
        )
        
        xYear = Double(2010 - referenceYear)
        let xp4 = ExPlace(
            name: "Donald J. Trump State Park",
            subtitle: "",
            description: "A failed attempt by Trump to build a golf course. The land was given away in exchange for an inflated tax break.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_donaldjtrumpstatepark",
            location: Location.point(latitude: 41.3430, longitude: -73.8081),
            notes: nil,
            uuid: UUID()
        )
        
        xYear = Double(1985  - referenceYear)
        let xp5 = ExPlace(
            name: "South Fremantle Power Station",
            subtitle: "",
            description: "A large empty shell of concrete, featuring a subterranean network of tunnels.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_southfremantlepowerstation",
            location: Location.point(latitude: -32.0886, longitude: 115.7572),
            notes: nil,
            uuid: UUID()
        )
        
        xYear = Double(1925 - referenceYear)
        let xp6 = ExPlace(
            name: "Tintic Standard Reduction Mill",
            subtitle: "",
            description: "Empty industrial fortress nestled in a hillside.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_tinticstandardreductionmill",
            location: Location.point(latitude: 39.9572, longitude: -111.8528),
            notes: nil,
            uuid: UUID()
        )
        
        xYear = Double(1938 - referenceYear)
        let xp7 = ExPlace(
            name: "Jerome's Sliding Jail",
            subtitle: "",
            description: "An old jail building that slid down a hill after some underground blasting.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_jeromesslidingjail",
            location: Location.point(latitude: 34.7508, longitude: -112.1147),
            notes: nil,
            uuid: UUID()
        )
        
        xYear = Double(1984 - referenceYear)
        let xp8 = ExPlace(
            name: "Holy Land, U.S.A.",
            subtitle: "",
            description: "A religious-themed amusement park, totally abandoned.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_holyland",
            location: Location.point(latitude: 41.5493, longitude: -73.0298),
            notes: nil,
            uuid: UUID()
        )
        
        xYear = Double(1890 - referenceYear)
        let xp9 = ExPlace(
            name: "Village of Bara-Hack",
            subtitle: "",
            description: "Small derelict Connecticut village. Scraps of a graveyard remain.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            image: "place_villageofbara-hack",
            location: Location.point(latitude: 41.8800, longitude: -72.0110),
            notes: nil,
            uuid: UUID()
        )
        
        return [xp1, xp2, xp3, xp4, xp5, xp6, xp7, xp8, xp9].sorted { $0.name.lowercased() < $1.name.lowercased() }
    }()
    
    func findExPlace(nearest place: ExPlace) -> ExPlace {
        let searchablePlaces = exPlaces.filter { $0 != place }
        var nearestPlace = searchablePlaces[0]
        var shortestDistance = place.distance(to: nearestPlace)!
        for otherPlace in searchablePlaces {
            if let otherDistance = place.distance(to: otherPlace) {
                if otherDistance < shortestDistance {
                    shortestDistance = otherDistance
                    nearestPlace = otherPlace
                }
            }
        }
        return nearestPlace
    }
    
    func findExPlace(usingID uuid: UUID) -> ExPlace? {
        if let index = exPlaces.firstIndex(where: { $0.uuid == uuid }) {
            return exPlaces[index]
        } else {
            return nil
        }
    }
    
    // Save a given ExPlace value back to storage.
    // Note: Storage in this implementation is not persistent! It only lasts as long as the use session.
    func save(_ exPlace: ExPlace) {
        if let index = exPlaces.firstIndex(where: { $0.uuid == exPlace.uuid }) {
            exPlaces[index] = exPlace
        }
    }
    
}
