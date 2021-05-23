//
//  NetworkResponse.swift
//  weather
//
//  Created by alex on 04.05.2021.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
