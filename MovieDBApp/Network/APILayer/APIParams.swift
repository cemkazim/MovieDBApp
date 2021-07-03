//
//  APIParams.swift
//  SearchApp
//
//  Created by Cem Kazım on 3.07.2021.
//

import Foundation

class URLCreator {
    
    public static let shared = URLCreator()
    
    private init() {}
    
    /// Description: Request the API data with parameters for popular movies.
    /// - Parameters:
    ///   - pageId: Page count of movie list.
    func createPopularMovieURL(pageId: Int) -> URL? {
        var components = baseURLComponents()
        components.path = "/3/movie/popular"
        components.queryItems?.append(URLQueryItem(name: "page", value: String(pageId)))
        return components.url
    }
    
    /// Description: Request the API data with parameters for movie details.
    /// - Parameters:
    ///   - movieId: Movie's identifier.
    func createMovieDetailURL(movieId: Int) -> URL? {
        var components = baseURLComponents()
        components.path = "/3/movie/\(movieId)"
        return components.url
    }
    
    /// Description: Generic URL components creator.
    func baseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "api_key", value: "fd2b04342048fa2d5f728561866ad52a")
        ]
        return components
    }
}

/// Description: Usable http methods.
enum HttpMethods: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
}
