//
//  MovieListViewController.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 1.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MovieListViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension MovieListViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        title = Constants.movieListTitle
        addSubviews()
        setupConstraints()
        setupCollectionView()
    }
    
    private func addSubviews() {
        view.addSubview(movieListCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.movieListCollectionViewCellID)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieListCollectionViewCellID, for: indexPath) as? MovieListCollectionViewCell {
            cell.setData(with: "Cemo", imageURL: URL(string: "https://image.tmdb.org/t/p/w185//2DyEk84XnbJEdPlGF43crxfdtHH.jpg"), indicator: .grayLarge)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
