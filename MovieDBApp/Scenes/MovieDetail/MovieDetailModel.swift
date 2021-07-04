//
//  MovieDetailModel.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 4.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  KeyZim-MVVM
//

import Foundation

// MARK: - MovieDetailModel

public struct MovieDetailModel: Decodable {
    
    let originalTitle: String?
    let voteCount: Int?
    let posterPath: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case overview
    }
}
