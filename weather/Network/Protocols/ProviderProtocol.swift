//
//  ProviderProtocol.swift
//  weather
//
//  Created by alex on 05.05.2021.
//

import Foundation

protocol ProviderProtocol {
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable 
}
