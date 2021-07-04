//
//  MovieDetailViewController.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 4.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  KeyZim-MVVM
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    private var scrollableStackView: ScrollableStackView = {
        let view = ScrollableStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(imageLiteralResourceName: Constants.placeholderPosterImageName)
        return imageView
    }()
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameLabel, movieVoteCountLabel, movieDescriptionLabel])
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var movieVoteCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private lazy var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    public var selectedMovieId = 0
    public var isMovieStarred = false
    private lazy var viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension MovieDetailViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        title = Constants.movieDetailTitle
        addSubviews()
        setupConstraints()
        viewModel = MovieDetailViewModel(movieId: selectedMovieId, delegate: self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: Constants.starEmptyImageName),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonTapped))
        updateRightBarButton()
    }
    
    private func addSubviews() {
        view.addSubview(scrollableStackView)
        scrollableStackView.addViewToStackView(movieImageView)
        scrollableStackView.addViewToStackView(labelStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollableStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollableStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollableStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            movieImageView.centerXAnchor.constraint(equalTo: scrollableStackView.centerXAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func updateRightBarButton() {
        isMovieStarred ? changeRightBarButtonImage(with: Constants.starFullImageName) : changeRightBarButtonImage(with: Constants.starEmptyImageName)
    }
    
    private func changeRightBarButtonImage(with imageName: String) {
        navigationItem.rightBarButtonItem?.image = UIImage(imageLiteralResourceName: imageName)
    }
    
    @objc func rightBarButtonTapped() {
        viewModel.updateStarredMovieData(with: selectedMovieId)
        isMovieStarred.toggle()
        updateRightBarButton()
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    
    func getMovieDetail(with model: MovieDetailModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.movieImageView.sd_setImage(with: URL(string: model.posterPath ?? ""))
            self.movieNameLabel.text = Constants.movieNameText + (model.originalTitle ?? "")
            self.movieVoteCountLabel.text = Constants.movieVoteCountText + String(model.voteCount ?? 0)
            self.movieDescriptionLabel.text = Constants.movieDescriptionText + (model.overview ?? "")
        }
    }
}
