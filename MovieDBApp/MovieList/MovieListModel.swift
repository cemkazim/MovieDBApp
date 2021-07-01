//
//  MovieListModel.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 1.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  KeyZim-MVVM
//

import Foundation

struct MovieListModel: Decodable {
    
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
