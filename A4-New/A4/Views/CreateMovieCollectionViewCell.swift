//
//  CreateMovieCollectionViewCell.swift
//  Hackathon
//
//  Created by Cole on 12/1/2023.
//

import UIKit

class CreateMovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    
    private let postButton = UIButton()
    private let textField = UITextField()
    
    // MARK: - Properties (data)
    
    static let reuse = "CreateMovieCollectionViewCellReuse"
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.a4.white
        layer.cornerRadius = 16
        
        setupTextField()
        setupPostButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views

    private func setupTextField() {
        textField.placeholder = "Enter the movie name, length, genre, and description, separated by commas"
        textField.font = .systemFont(ofSize: 16)
        
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let sidePadding: CGFloat = 24
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sidePadding)
        ])
    }
    
    private func setupPostButton() {
        postButton.backgroundColor = UIColor.a4.yellowOrange
        postButton.layer.cornerRadius = 4
        postButton.setTitle("Post Movie", for: .normal)
        postButton.setTitleColor(UIColor.a4.white, for: .normal)
        postButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        postButton.addTarget(self, action: #selector(createMovie), for: .touchUpInside)
        
        contentView.addSubview(postButton)
        contentView.addSubview(textField)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        
        let sidePadding: CGFloat = 24
        NSLayoutConstraint.activate([
            postButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            postButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -sidePadding),
            postButton.widthAnchor.constraint(equalToConstant: 96),
            postButton.heightAnchor.constraint(equalToConstant: 32),
            postButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32)
        ])
    }
    
    // MARK: - Button Helpers
    
    @objc private func createMovie() {
        // TODO: Send a POST request to create a post
        let message = textField.text
        let post = message?.components(separatedBy: ", ")
        let name = post?[0]
        let length = post?[1]
        let run: String = length!
        let myRun = Int(run)
        let genre = post?[2]
        let desc = post?[3]
        NetworkManager.shared.addMovie(title: name ?? "", length: myRun ?? 0, genre: genre ?? "", description: desc ?? "") { name in }
        
    }
    
}
