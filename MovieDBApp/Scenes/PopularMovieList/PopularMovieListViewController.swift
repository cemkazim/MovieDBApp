//
//  PopularMovieListViewController.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 1.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class PopularMovieListViewController: UIViewController {
    
    private var movieListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setCollectionViewLayout(layout, animated: true)
        view.backgroundColor = .clear
        view.backgroundView = UIView.init(frame: .zero)
        return view
    }()
    private lazy var loadMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Load More", for: .normal)
        button.addTarget(self, action: #selector(loadMoreButtonClicked), for: .touchUpInside)
        button.isHidden = true
        button.titleLabel?.font = UIFont(name: "Campton-Medium", size: 12)
        button.titleLabel?.textColor = .white
        return button
    }()
    private var viewModel = PopularMovieListViewModel()
    private var movieList = [ResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func loadMoreButtonClicked() {
        viewModel.increasePageCount()
        viewModel.getData()
        movieListCollectionView.reloadData()
        loadMoreButton.isHidden = true
    }
}

extension PopularMovieListViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        title = Constants.movieListTitle
        viewModel.delegate = self
        addSubviews()
        setupConstraints()
        setupCollectionView()
    }
    
    private func addSubviews() {
        view.addSubview(movieListCollectionView)
        view.addSubview(loadMoreButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadMoreButton.bottomAnchor.constraint(equalTo: movieListCollectionView.bottomAnchor, constant: -10),
            loadMoreButton.heightAnchor.constraint(equalToConstant: 40),
            loadMoreButton.widthAnchor.constraint(equalToConstant: 100),
            loadMoreButton.centerXAnchor.constraint(equalTo: movieListCollectionView.centerXAnchor)
        ])
    }
    
    private func setupCollectionView() {
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: Constants.movieListCollectionViewCellID)
    }
}

extension PopularMovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieListCollectionViewCellID, for: indexPath) as? MovieListCollectionViewCell {
            let movieTitle = movieList[indexPath.row].title
            let movieImageURL = movieList[indexPath.row].posterPath
            cell.setData(with: movieTitle, imageURL: URL(string: movieImageURL ?? ""), indicator: .grayLarge)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if movieList.count == viewModel.getPageItemCount() * viewModel.getCurrentPageNumber() {
            if indexPath.row == movieList.count - 1 {
                loadMoreButton.isHidden = false
            }
        }
    }
}

extension PopularMovieListViewController: PopularMovieListViewModelDelegate {
    
    func getResultModel(movies: [ResultModel]) {
        movieList = movies
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movieListCollectionView.reloadData()
        }
    }
}
