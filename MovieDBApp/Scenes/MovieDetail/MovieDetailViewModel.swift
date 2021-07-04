//
//  MovieDetailViewModel.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 4.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  KeyZim-MVVM
//

import UIKit
import CoreData

// MARK: - MovieDetailViewModelDelegate

protocol MovieDetailViewModelDelegate: class {
    func getMovieDetail(with model: MovieDetailModel)
}

class MovieDetailViewModel {
    
    // MARK: - Properties
    
    weak var delegate: MovieDetailViewModelDelegate?
    private var coreDataHelper = CoreDataHelper()
    private var lastStarredMovieIdList = [Int]()
    
    // MARK: - Initializers
    
    init(movieId: Int? = nil, delegate: MovieDetailViewModelDelegate? = nil) {
        self.delegate = delegate
        getData(movieId: movieId)
    }
    
    // MARK: - Methods
    
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
    
    private func saveStarredMovieData(movieId: Int, isStarred: Bool) {
        let entity = coreDataHelper.addData(entityName: Constants.starredMoviesEntityName)
        let newValue = NSManagedObject(entity: entity, insertInto: CoreDataHelper.context)
        newValue.setValue(movieId, forKey: Constants.movieIdKey)
        saveToCoreData()
    }
    
    private func saveToCoreData() {
        do {
            try CoreDataHelper.context.save()
        } catch let error {
            print(error)
        }
    }
    
    private func getStarredMovieData() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.starredMoviesEntityName)
            fetchRequest.returnsObjectsAsFaults = false
            setStarredMovieIdList(fetchRequest: fetchRequest, context: context)
        }
    }
    
    private func setStarredMovieIdList(fetchRequest: NSFetchRequest<NSFetchRequestResult>, context: NSManagedObjectContext) {
        do {
            let results = try context.fetch(fetchRequest)
            if let starredMovies = results as? [NSManagedObject], starredMovies.count > 0 {
                for result in starredMovies {
                    guard let movieId = result.value(forKey: Constants.movieIdKey) as? Int else { return }
                    lastStarredMovieIdList.append(movieId)
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    private func deleteStarredMovieData() {
        let entity = coreDataHelper.deleteData(entityName: Constants.starredMoviesEntityName)
        guard let results = try? CoreDataHelper.context.fetch(entity),
              results.count > 0,
              let starredMovies = results as? [NSManagedObject] else { return }
        do {
            for result in starredMovies {
                if let movieId = result.value(forKey: Constants.movieIdKey) as? Int,
                   lastStarredMovieIdList.contains(where: { $0 == movieId }),
                   let movieIdIndex = lastStarredMovieIdList.firstIndex(of: movieId) {
                    CoreDataHelper.context.delete(result)
                    lastStarredMovieIdList.remove(at: movieIdIndex)
                    try CoreDataHelper.context.save()
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    public func updateStarredMovieData(with movieId: Int) {
        getStarredMovieData()
        let isStarred = lastStarredMovieIdList.contains(where: { $0 == movieId })
        isStarred ? deleteStarredMovieData() : saveStarredMovieData(movieId: movieId, isStarred: isStarred)
    }
}
