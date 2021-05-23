//
//  ProviderProtocol.swift
//  weather
//
//  Created by alex on 04.05.2021.
//

import Foundation

final class URLSessionProvider: ProviderProtocol {

    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable {
        
        let urlString = service.baseUrl.appendingPathComponent(service.path)
        let queryItems = service.parameters.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        let urlComponents = URLComponents(url: urlString, resolvingAgainstBaseURL: false)
        
        guard let url = urlComponents?.url else { return }
        var urlRequest = URLRequest(url: url)
        
        service.headers?.forEach({ key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: service.parameters)
        
        let task = session.dataTask(request: urlRequest) { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        }
        
        task.resume()
    }
    
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> ()) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }
        
        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(.failure(.unknown))
            }
            completion(.success(model))
        default:
            completion(.failure(.unknown))
        }
    }
}
