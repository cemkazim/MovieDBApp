//
//  TypeAliases.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 3.07.2021.
//

import Foundation

typealias RequestCompletion<T> = (Result<T, Error>) -> Void
typealias PopularMovieCompletion = (Result<PopularMovieListModel, Error>) -> Void
typealias MovieDetailCompletion = (Result<MovieDetailModel, Error>) -> Void
typealias MovieDetailModelCallback = ((MovieDetailModel?) -> ())
