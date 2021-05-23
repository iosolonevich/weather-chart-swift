//
//  Location.swift
//  weather
//
//  Created by alex on 04.05.2021.
//

import Foundation

struct Location: Codable, Equatable {
    let locationName: String
    let locationOWMId: Int
    var id: Int
    let latitude: Double
    let longitude: Double
//    let currentTemperature: Int?
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.locationName == rhs.locationName || lhs.locationOWMId == rhs.locationOWMId
    }
}
