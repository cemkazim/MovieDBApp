//
//  MovieDetailServiceLayer.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 4.07.2021.
//

import Foundation

class MovieDetailServiceLayer {
    
    static let shared = MovieDetailServiceLayer()
    
    private init() {}
    
    /// Description: Request the API data with parameters.
    /// - Parameters:
    ///   - pageCount:Page count of movie list
    ///   - completionHandler: Pass the data with completion
    func getMovieDetail(movieId: Int, completionHandler: @escaping MovieDetailCompletion) {
        let url = URLCreator.shared.createMovieDetailURL(movieId: movieId)
        guard let requestURL = url else { return }
        BaseNetworkLayer.shared.request(url: requestURL, requestMethod: .get) { (result: Result<MovieDetailModel, Error>) in
            completionHandler(result)
        }
    }
}
