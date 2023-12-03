//
//  UICollectionViewCell.swift
//  Hackathon
//
//  Created by Cole and Jamayne on 11/25/23.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties (view)
    
    private let movieImage = UIImageView()
    private let movieName = UILabel()
    private let movieRuntime = UILabel()
    
    // MARK: - Properties (data)
    
    static let reuse = "MovieCollectionViewReuse"
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        setupMovieImageView()
        setupMovieName()
        setupMovieRuntime()
        
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    
    func configure(movie: Movie) {
        movieName.text = movie.name
        movieRuntime.text = "Minutes: " + String(movie.length)
    }
    
    // MARK: - Set Up Views
    
    private func setupMovieImageView() {
        
        movieImage.image = UIImage(named: "MovieIMG.jpeg")
        
        movieImage.contentMode = .scaleAspectFill
        
        movieImage.layer.cornerRadius = 12
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.clipsToBounds = true
        
        contentView.addSubview(movieImage)
        
        
        
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: 148),
            movieImage.widthAnchor.constraint(equalToConstant: 148)
        ])
    }
    
    private func setupMovieName() {
        movieName.textColor = .label
        movieName.font = .systemFont(ofSize: 16, weight: .semibold).rounded
        movieName.numberOfLines = 2
        
        contentView.addSubview(movieName)
        
        movieName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 8),
            movieName.widthAnchor.constraint(equalToConstant: 148)
        ])
        
    }
    
    private func setupMovieRuntime() {
        movieRuntime.textColor = UIColor.a4.silver
        movieRuntime.font = .systemFont(ofSize: 12, weight: .regular).rounded
        
        contentView.addSubview(movieRuntime)
        
        movieRuntime.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieRuntime.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 4),
            movieRuntime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
}
