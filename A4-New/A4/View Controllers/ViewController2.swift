//
//  SecondViewController.swift
//  Hackathon
//
//  Created by Cole and Jamayne on 11/25/23.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class SecondViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private let movieImage = UIImageView()
    private let movieName = UILabel()
    private let movieDescription = UILabel()
    
    // MARK: - Properties (data)
    // private var movieImageName: String
    private var movieDescriptionText: String
    private var movieNameText: String
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupMovieImage()
        setupMovieName()
        setupMovieDescription()
    }
    
    init(movieName: String, movieDescription: String) {
        self.movieNameText = movieName
        self.movieDescriptionText = movieDescription
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    
    private func setupMovieImage() {
        movieImage.image = UIImage(named: "MovieIMG.jpeg")
        movieImage.contentMode = .scaleAspectFill
        
        movieImage.layer.cornerRadius = 12
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.clipsToBounds = true
        
        view.addSubview(movieImage)
        
        
        
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: 329),
            movieImage.widthAnchor.constraint(equalToConstant: 329),
            movieImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 99),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupMovieName() {
        movieName.text = movieNameText
        movieName.textColor = .label
        movieName.font = .systemFont(ofSize: 24, weight: .semibold).rounded
        movieName.numberOfLines = 0
        movieName.textAlignment = .center
    
        
        view.addSubview(movieName)
        
        movieName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 32),
            movieName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
        ])
        
    }
    
    private func setupMovieDescription() {
        movieDescription.text = movieDescriptionText
        movieDescription.textColor = .label
        movieDescription.font = .systemFont(ofSize: 14, weight: .medium).rounded
        movieDescription.textColor = UIColor.a4.silver
        movieDescription.numberOfLines = 0
        view.addSubview(movieDescription)
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDescription.leadingAnchor.constraint(equalTo: movieName.leadingAnchor),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            movieDescription.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 16)
        ])
    }
    
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
