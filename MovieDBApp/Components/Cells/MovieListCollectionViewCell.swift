//
//  PopularMovieListCollectionViewCell.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 1.07.2021.
//

import UIKit
import SDWebImage

class PopularMovieListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(imageLiteralResourceName: "placeholder_poster.png")
        return imageView
    }()
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(imageLiteralResourceName: "star_full.png")
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(movieNameLabel)
        addSubview(movieImageView)
        addSubview(starImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieImageView.widthAnchor.constraint(equalToConstant: 150),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            movieImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            movieNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            starImageView.leadingAnchor.constraint(lessThanOrEqualTo: movieNameLabel.trailingAnchor, constant: 5),
            starImageView.widthAnchor.constraint(equalToConstant: 20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),
            starImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -5)
        ])
    }
}

// MARK: - Extension: PopularMovieListCollectionViewCell

extension PopularMovieListCollectionViewCell {
    
    public func setMovieData(popularMovieList: [ResultModel], starredMovieIdList: [Int], indexPath: IndexPath) {
        movieNameLabel.text = popularMovieList[indexPath.row].title
        movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        movieImageView.sd_setImage(with: URL(string: popularMovieList[indexPath.row].posterPath ?? ""))
        if starredMovieIdList.count > 0 {
            let isStarred = starredMovieIdList.contains(where: { $0 == popularMovieList[indexPath.row].id })
            starImageView.isHidden = !isStarred
        }
    }
}
