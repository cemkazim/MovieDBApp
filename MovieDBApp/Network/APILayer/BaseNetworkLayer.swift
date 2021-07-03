//
//  BaseNetworkLayer.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 3.07.2021.
//

import Foundation

class BaseNetworkLayer {
    
    static let shared = BaseNetworkLayer()
    
    private init() {}
    
    /// Description: Request the API data with parameters (T is a decodable model).
    /// - Parameters:
    ///   - url: Formatted url for API data
    ///   - requestMethod: Any HTTPMethod
    ///   - onComplete: Pass the data with completion
    func request<T: Decodable>(url: URL, requestMethod: HttpMethods, onComplete: @escaping RequestCompletion<T>) {
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        let task = URLSession.shared
        task.dataTask(with: request) { (data, response, error) in
            guard let remoteData = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: remoteData)
                onComplete(.success(decodedData))
            } catch {
                onComplete(.failure(error))
            }
        }.resume()
    }
}
