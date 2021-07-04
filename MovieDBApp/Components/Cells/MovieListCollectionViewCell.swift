//
//  MovieListCollectionViewCell.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 1.07.2021.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    
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
        imageView.image = UIImage(imageLiteralResourceName: "star.png")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

extension MovieListCollectionViewCell {
    
    public func setData(with nameText: String?, imageURL: URL?, indicator: SDWebImageActivityIndicator?) {
        movieNameLabel.text = nameText
        movieImageView.sd_imageIndicator = indicator
        movieImageView.sd_setImage(with: imageURL)
    }
}
