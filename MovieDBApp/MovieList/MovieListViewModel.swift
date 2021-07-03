//
//  MovieListViewModel.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 1.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  KeyZim-MVVM
//

import Foundation

protocol MovieListViewModelDelegate: class {
}

class MovieListViewModel {
    
    // MARK: - Properties -
    
    weak var delegate: MovieListViewModelDelegate?
    
    // MARK: - Initialize -
    
    init() {}
    
    // MARK: - Methods -
    func getPopularMoviesData() {
        // This method is written for data of the popular movie list from api.
    }
}
