//
//  LocationManager.swift
//  weather
//
//  Created by alex on 04.05.2021.
//

import Foundation

class LocationManager {

    init() {
        //persist(using: locationsKeyword)
    }
    
    private var locations = [ Location(locationName: "Prague", locationOWMId: 3067696, id: 1, latitude: 50.0755, longitude: 14.4378), Location(locationName: "New York", locationOWMId: 5128581, id: 2, latitude: 40.7128, longitude: -74.006) ]
    
    private let locationsKeyword = "locationsKey"
    
    func getLocations() -> [Location] {
        let fetchedLocations = fetch(using: locationsKeyword)
        return fetchedLocations ?? [Location]()
    }
    
    func saveLocation(_ location: Location) {
        locations.append(location)
        persist(using: locationsKeyword)
    }
    
    func deleteLocation(_ location: Location) {
        if let index = locations.firstIndex(where: { $0.locationName == location.locationName }) {
            locations.remove(at: index)
            persist(using: locationsKeyword)
        }
        
    }
    
    func getDefaultOrder() -> Int {
        if locations.count == 0 {
            return 1
        } else {
            return (locations.map { $0.id }.max()!) + 1
        }
    }
    
    func reorderLocations(moveRowAt sourceIndex: Int, to destinationIndex: Int) {
        
        let locationToMove = locations[sourceIndex]
        locations.remove(at: sourceIndex)
        locations.insert(locationToMove, at: destinationIndex)
        
        for i in 0...locations.count - 1 {
            locations[i].id = i + 1
        }
        
        persist(using: locationsKeyword)
    }
    
    private func persist(using key: String) {
        do {
            let encodedLocations = try JSONEncoder().encode(locations)
            UserDefaults.standard.setValue(encodedLocations, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetch(using key: String) -> [Location]? {
        do {
            guard let persistedLocations = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
            let decodedLocations = try JSONDecoder().decode([Location].self, from: persistedLocations)
            return decodedLocations
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
