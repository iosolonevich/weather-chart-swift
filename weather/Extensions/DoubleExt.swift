//
//  DoubleExt.swift
//  weather
//
//  Created by alex on 13.05.2021.
//

import Foundation

extension Double {
    func convertKelvinToCelsius() -> Double {
        return self - 273.15
    }
    
    func convertKelvinToFahrenheit() -> Double {
        return 1.8 * (self - 273.15) + 32
    }
}
