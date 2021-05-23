//
//  ForecastProvider.swift
//  weather
//
//  Created by alex on 04.05.2021.
//

import Foundation

enum ForecastProvider: ServiceProtocol {
    
    case oneCall(lat: Double, lon: Double, exclude: [ExcludePart]?)
    
    var baseUrl: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    var path: String {
        switch self {
        case .oneCall:
            return "onecall"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var parameters: [String: String] {
        switch self {
        case let .oneCall(lat, lon, exclude):
            var excludeString = ""
            if let exclude = exclude {
                excludeString = exclude.map { $0.rawValue }.joined(separator: ",")
            }
            
            var parameters: [String: String] = [ "apikey": "XXXXXXXXXX", "lat": String(lat), "lon": String(lon) ]
            
            if excludeString != "" {
                parameters["exclude"] = excludeString
            }
            
            return parameters
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: String {
        return "url"
    }
}
