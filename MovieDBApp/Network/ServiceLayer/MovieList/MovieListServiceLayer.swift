//
//  MovieListServiceLayer.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 3.07.2021.
//

import Foundation

class MovieListServiceLayer {
    
    static let shared = MovieListServiceLayer()
    
    private init() {}
    
    /// Description: Request the API data with parameters.
    /// - Parameters:
    ///   - pageCount:Page count of movie list
    ///   - completionHandler: Pass the data with completion
    func getPopularMovies(pageId: Int, completionHandler: @escaping PopularMovieCompletion) {
        let url = URLCreator.shared.createPopularMovieURL(pageId: pageId)
        guard let requestURL = url else { return }
        BaseNetworkLayer.shared.request(url: requestURL, requestMethod: .get) { (result: Result<PopularMovieListModel, Error>) in
            completionHandler(result)
        }
    }
}
