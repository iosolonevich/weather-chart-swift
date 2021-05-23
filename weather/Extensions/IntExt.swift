//
//  IntExt.swift
//  weather
//
//  Created by alex on 13.05.2021.
//

import Foundation

extension Int {
    func getDateComponentFromUnixTime(component: Calendar.Component) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        if component == .weekday {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
        return String(Calendar.current.component(component, from: date))
    }
}
