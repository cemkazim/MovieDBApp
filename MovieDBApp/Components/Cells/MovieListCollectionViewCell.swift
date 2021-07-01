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
        return label
    }()
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieImageView.widthAnchor.constraint(equalToConstant: 150),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            movieImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 5),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieImageView.widthAnchor.constraint(equalToConstant: 150)
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
