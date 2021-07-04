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

protocol PopularMovieListViewModelDelegate: class {
    func getResultModel(movies: [ResultModel])
}

class PopularMovieListViewModel {
    
    private var pageCount = 1
    private var popularMovieList = [ResultModel]()
    weak var delegate: PopularMovieListViewModelDelegate?
    
    init() {
        getData()
    }
    
    public func getData() {
        MovieListServiceLayer.shared.getPopularMovies(pageId: pageCount) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handlePopularMoviesData(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func handlePopularMoviesData(_ response: PopularMovieListModel) {
        if let results = response.results {
            for result in results {
                if let title = result.title, let imageURL = result.posterPath {
                    let resultModel = ResultModel(title: title, posterPath: Constants.movieImageBaseURLPath + imageURL)
                    popularMovieList.append(resultModel)
                }
            }
            delegate?.getResultModel(movies: popularMovieList)
        }
    }
    
    public func increasePageCount() {
        pageCount += 1
    }
    
    public func getCurrentPageNumber() -> Int {
        return pageCount
    }
    
    public func getPageItemCount() -> Int {
        return 20
    }
}
