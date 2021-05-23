//
//  ServiceProtocol.swift
//  weather
//
//  Created by alex on 04.05.2021.
//

import Foundation

typealias Headers = [String: String]

protocol ServiceProtocol {
    var baseUrl: URL { get }
    var path: String { get }
    var method: String { get }
    var parameters: [String: String] { get }
    var headers: Headers? { get }
    var parametersEncoding: String { get }
}
