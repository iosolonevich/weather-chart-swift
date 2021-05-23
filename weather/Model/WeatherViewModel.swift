//
//  WeatherViewModel.swift
//  weather
//
//  Created by alex on 13.05.2021.
//

import Foundation

struct WeatherViewModel {
    private var weatherModel: WeatherModel?
    
    // unit types
    private var temperatureUnit: TemperatureUnit
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
        temperatureUnit = .celsius
    }
    
    var dailyDataEntries: [PointEntry]? {
        var entries = [PointEntry]()
        guard let weatherModel = weatherModel else { return nil }
        for i in 0..<weatherModel.hourly.count {
            let hourModel = weatherModel.hourly[i]
            let hour = hourModel.dt.getDateComponentFromUnixTime(component: .hour)
            let temperature = temperatureUnit == .celsius
                ? Int(hourModel.temp.convertKelvinToCelsius())
                : Int(hourModel.temp.convertKelvinToFahrenheit())
            
            
            
            entries.append(PointEntry(value: Int(temperature), axisLabel: hour, pointLabel: String(temperature), icon: hourModel.weather.first?.icon))
        }
        return entries
    }
    
    var currentTemperature: String {
        guard let temp = weatherModel?.current.temp else { return "-" }
        switch temperatureUnit {
        case .celsius:
            return String(Int(temp.convertKelvinToCelsius()))
        case .fahrenheit:
            return String(Int(temp.convertKelvinToFahrenheit()))
        }
    }
}
