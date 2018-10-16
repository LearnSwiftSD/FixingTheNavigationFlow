//
//  ExSpeciesService.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// A volatile data service for authoritative ExSpecies data.
// There is no data persistence from session to session.

import Foundation

class ExSpeciesService {
    
    // kludge: Add a few days time to Date calculations to counter leap year cutoff offsets that would push year back by 1.
    // These calculated dates are all Jan 1 values. The year is the significant value here.
    private let bufferTime = 100_000.0
    
    private let secondsInAYear = 31557600.0
    private let referenceYear = 2001
    
    lazy var exSpecies: Array<ExSpecies> = {
        
        var xYear = Double(1955 - referenceYear)
        let xs1 = ExSpecies(
            commonName: "Little Swan Island hutia",
            description: "A slow-moving, guinea-pig-like rodent. It disappeard in 1955 after a severe hurricane, followed by the introduction of house cats to the island.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.mammal,
            habitat: [NamedPlace(name: "Swan Islands", subtitle:"", location: Location.point(latitude: 17.4197, longitude: -83.9386))],
            image: "species_hutia",
            notes: nil,
            scientificName: "Geocapromys thoracatus",
            uuid: UUID()
        )
        
        xYear = Double(1800 - referenceYear)
        let xs2 = ExSpecies(
            commonName: "Saddle-backed Rodrigues giant tortoise",
            description: "The saddle-backed Rodrigues giant tortoise was an exceptionally tall species of giant tortoise, with a long, raised neck and an upturned carapace, which gave it a giraffe-like body shape almost similar to that of a sauropod dinosaur.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.reptile,
            habitat: [NamedPlace(name: "Rodrigues Island", subtitle:"", location: Location.point(latitude: -19.7146, longitude: 63.4167))],
            image: "species_tortoise",
            notes: nil,
            scientificName: "Cylindraspis vosmaeri",
            uuid: UUID()
        )
        
        xYear = Double(1945 - referenceYear)
        let xs3 = ExSpecies(
            commonName: "Wake Island rail",
            description: "A dark greyish-brown bird with striking narrow white bars on the belly, the breast, and the flanks. It was forced to extinction from bombardment and predation by starving troops during World War II.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.bird,
            habitat: [NamedPlace(name: "Wake Island", subtitle:"", location: Location.point(latitude: 19.2866, longitude: 166.6379))],
            image: "species_rail",
            notes: nil,
            scientificName: "Gallirallus wakensis",
            uuid: UUID()
        )
        
        xYear = Double(1500 - referenceYear)
        let xs4 = ExSpecies(
            commonName: "Puerto Rican nesophontes",
            description: "A shrew that lived in an island forest/brush environment. It disappeared due to destruction of its habitat and the introduction of rats.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.mammal,
            habitat: [NamedPlace(name: "Puerto Rico", subtitle:"", location: Location.point(latitude: 18.3021, longitude: -65.7923))],
            image: "species_shrew",
            notes: nil,
            scientificName: "Nesophontes edithae",
            uuid: UUID()
        )
        
        xYear = Double(1900 - referenceYear)
        let xs5 = ExSpecies(
            commonName: "Cape Verde giant skink",
            description: "A mostly herbivorous but opportunistically carnivorous island reptile with a transparent lower eyelid. It became extinct from over hunting combined with drought.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.reptile,
            habitat: [NamedPlace(name: "Ilheu Branco", subtitle:"", location: Location.point(latitude: 16.6583, longitude: -24.6697)),
                      NamedPlace(name: "Ilheu Raso", subtitle:"", location: Location.point(latitude: 16.6170, longitude: -24.5993))],
            image: "species_skink",
            notes: nil,
            scientificName: "Chioninia coctei",
            uuid: UUID()
        )
        
        xYear = Double(1852 - referenceYear)
        let xs6 = ExSpecies(
            commonName: "great auk",
            description: "A flightless bird that foraged for food in the ocean and formed lifelong mating pairs. They were hunted to extinction.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.bird,
            habitat: [NamedPlace(name: "Newfoundland", subtitle:"", location: Location.point(latitude: 47.5045, longitude: -52.8494)),
                      NamedPlace(name: "Greenland", subtitle:"", location: Location.point(latitude: 59.9512, longitude: -44.5745)),
                      NamedPlace(name: "Iceland", subtitle:"", location: Location.point(latitude: 64.7905, longitude: -23.8322))],
            image: "species_auk",
            notes: nil,
            scientificName: "Pinguinus impennis",
            uuid: UUID()
        )
        
        xYear = Double(1970 - referenceYear)
        let xs7 = ExSpecies(
            commonName: "Japanese sea lion",
            description: "A dark grey aquatic sea mammal, about 2.5 meters long. They were captured for use in circuses and hunted for their oil before disappearing altogether.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.mammal,
            habitat: [NamedPlace(name: "Japan", subtitle:"", location: Location.point(latitude: 41.1681, longitude: 140.5760))],
            image: "species_sealion",
            notes: nil,
            scientificName: "Zalophus japonicus",
            uuid: UUID()
        )
        
        xYear = Double(1931 - referenceYear)
        let xs8 = ExSpecies(
            commonName: "Lesser bilby",
            description: "An omnivorous rabbit-like marsupial, yellowish-brown to grey-brown in color. Its extinction was most likely caused by the introduction of foreign predators.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.mammal,
            habitat: [NamedPlace(name: "Australia", subtitle:"", location: Location.point(latitude: -24.9345, longitude: 122.4537))],
            image: "species_bilby",
            notes: nil,
            scientificName: "Macrotis leucura",
            uuid: UUID()
        )
        
        xYear = Double(1851 - referenceYear)
        let xs9 = ExSpecies(
            commonName: "Norfolk kaka",
            description: "Olive-brown on top, staw-colored and orange underneath, this bird had a long curved beak with a call that resembled the barking of a dog. This species was hunted to extinction.",
            extinctionDate: Date(timeIntervalSinceReferenceDate: xYear * secondsInAYear + bufferTime),
            generalClass: ExSpecies.GeneralClass.bird,
            habitat: [NamedPlace(name: "Norfolk Island", subtitle:"", location: Location.point(latitude: -29.0272, longitude: 167.9516))],
            image: "species_kaka",
            notes: nil,
            scientificName: "Nestor productus",
            uuid: UUID()
        )
        
        return [xs1, xs2, xs3, xs4, xs5, xs6, xs7, xs8, xs9].sorted { $0.commonName.lowercased() < $1.commonName.lowercased() }
    }()
    
    // MARK: - Search functions.
    
    // Find ExSpecies matching requested generalClass.
    func findExSpecies(
        matchingGeneralClass generalClass: ExSpecies.GeneralClass, excepting exceptionSpecies: Array<ExSpecies> = [], limitedTo countLimit: Int? = nil) -> Array<ExSpecies> {
        // Get all species with matching requested generalClass.
        var matchingSpecies = exSpecies.filter { $0.generalClass == generalClass }
        
        // Exclude any exceptions.
        matchingSpecies = matchingSpecies.filter { filteredElement in
            return !exceptionSpecies.contains { exceptionElement in
                return exceptionElement.uuid == filteredElement.uuid
            }
        }
        
        // Limit the results.
        if let limit = countLimit, matchingSpecies.count > limit {
            if limit < 1 {
                return []
            } else {
                // The number of matching species exceeds the requested limit.
                // Return a randomly selected number of matching species equaling the limit.
                var matchingSpeciesPool = matchingSpecies
                matchingSpecies = []
                for _ in 1...limit {
                    matchingSpecies.append(matchingSpeciesPool.remove(at: Int.random(in: 1...matchingSpeciesPool.count-1)))
                }
            }
        }
        
        return matchingSpecies
    }
    
    // Find single ExSpecies nearest given AnnotatedPlace.
    func findExSpecies(nearest place: AnnotatedPlace) -> ExSpecies {
        var nearestSpecies = exSpecies[0]
        var shortestDistance = place.distance(to: nearestSpecies.habitat[0])!
        for otherSpecies in exSpecies {
            if let otherDistance = place.distance(to: otherSpecies.habitat[0]) {
                if (otherDistance < shortestDistance) || (shortestDistance == 0) {
                    shortestDistance = otherDistance
                    nearestSpecies = otherSpecies
                }
            }
        }
        return nearestSpecies
    }
    
    func findExSpecies(usingID uuid: UUID) -> ExSpecies? {
        if let index = exSpecies.firstIndex(where: { $0.uuid == uuid }) {
            return exSpecies[index]
        } else {
            return nil
        }
    }
    
    // Save a given ExSpecies value back to storage.
    // Note: Storage in this implementation is not persistent! It only lasts as long as the use session.
    func save(_ exSpeciesValue: ExSpecies) {
        if let index = exSpecies.firstIndex(where: { $0.uuid == exSpeciesValue.uuid }) {
            exSpecies[index] = exSpeciesValue
        }
    }
    
}
