//
//  PopularMovieListModel.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 1.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  KeyZim-MVVM
//

import Foundation

// MARK: - PopularMovieListModel

public struct PopularMovieListModel: Decodable {
    
    let page: Int?
    let results: [ResultModel]?
}

// MARK: - ResultModel

public struct ResultModel: Decodable {
    
    let title: String?
    let posterPath: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case title, id
        case posterPath = "poster_path"
    }
}
