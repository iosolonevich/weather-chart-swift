//
//  SettingsSection.swift
//  weather
//
//  Created by alex on 12.06.2021.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Appearance
//    case General
    case Other
    
    var description: String {
        switch self {
        case .Appearance: return "APPEARANCE"
//        case .General: return "GENERAL"
        case .Other: return "OTHER"
        }
    }
}

enum AppearanceOptions: Int, CaseIterable, SectionType {
    case units
    case theme
    
    var containsSwitch: Bool {
        switch self {
        case .units: return false
        case .theme: return true
        }
    }
    
    var description: String {
        switch self {
        case .units: return "Units"
        case .theme: return "Dark mode"
        }
    }
}

//enum GeneralOptions: Int, CaseIterable, CustomStringConvertible {
//
//}

enum OtherOptions: Int, CaseIterable, SectionType {
    case emailSupport
    case rateThisApp
    case privacy
    case about
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .emailSupport: return "Email Suppport"
        case .rateThisApp: return "Rate This App"
        case .privacy: return "Privacy Policy"
        case .about: return "About The App"
        }
    }
}

