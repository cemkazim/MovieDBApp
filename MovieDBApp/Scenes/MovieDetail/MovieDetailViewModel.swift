//
//  MovieDetailViewModel.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 4.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  KeyZim-MVVM
//

import Foundation

protocol MovieDetailViewModelDelegate: class {
    func getMovieDetail(with model: MovieDetailModel)
}

class MovieDetailViewModel {
    
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieId: Int? = nil, delegate: MovieDetailViewModelDelegate? = nil) {
        self.delegate = delegate
        getData(movieId: movieId)
    }
    
    public func getData(movieId: Int?) {
        MovieDetailServiceLayer.shared.getMovieDetail(movieId: movieId ?? 0) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handleMovieDetailData(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func handleMovieDetailData(_ response: MovieDetailModel) {
        guard let title = response.originalTitle,
              let voteCount = response.voteCount,
              let imageURL = response.posterPath,
              let description = response.overview else { return }
        let model = MovieDetailModel(originalTitle: title, voteCount: voteCount, posterPath: Constants.movieImageBaseURLPath + imageURL, overview: description)
        delegate?.getMovieDetail(with: model)
    }
}
