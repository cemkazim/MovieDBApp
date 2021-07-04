//
//  MovieListViewModel.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 1.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  KeyZim-MVVM
//

import UIKit
import CoreData

protocol PopularMovieListViewModelDelegate: class {
    func getPopularMovie(with popularMovieList: [ResultModel])
    func getStarredMovie(with starredMovieIdList: [Int])
}

class PopularMovieListViewModel {
    
    private var pageCount = 1
    private var popularMovieList = [ResultModel]()
    private var starredMovieIdList = [Int]()
    weak var delegate: PopularMovieListViewModelDelegate?
    
    init(delegate: PopularMovieListViewModelDelegate? = nil) {
        self.delegate = delegate
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
                if let title = result.title, let imageURL = result.posterPath, let movieId = result.id {
                    let resultModel = ResultModel(title: title, posterPath: Constants.movieImageBaseURLPath + imageURL, id: movieId)
                    popularMovieList.append(resultModel)
                }
            }
            delegate?.getPopularMovie(with: popularMovieList)
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
    
    public func getStarredMovieData() {
        starredMovieIdList.removeAll()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.starredMoviesEntityName)
            fetchRequest.returnsObjectsAsFaults = false
            checkStarredMovie(fetchRequest: fetchRequest, context: context)
        }
    }
    
    public func checkStarredMovie(fetchRequest: NSFetchRequest<NSFetchRequestResult>, context: NSManagedObjectContext) {
        do {
            let results = try context.fetch(fetchRequest)
            if let results = results as? [NSManagedObject] {
                if results.count > 0 {
                    for result in results {
                        guard let movieId = result.value(forKey: Constants.movieIdKey) as? Int else { return }
                        starredMovieIdList.append(movieId)
                    }
                }
            }
            delegate?.getStarredMovie(with: starredMovieIdList)
        } catch let error {
            print(error)
        }
    }
}
