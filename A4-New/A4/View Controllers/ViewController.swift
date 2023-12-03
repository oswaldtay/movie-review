//
//  ViewController.swift
//  Hackathon
//
//  Created by Cole and Jamayne on 11/24/23.
//

import UIKit
import SnapKit
import SDWebImage

class ViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private var collectionView: UICollectionView!
    private var collectionView2: UICollectionView!
    private var collectionView3: UICollectionView!
    private var selectedGenre: String?
    private var selectedFilterIndex: Int = 0
    
    // MARK: - Properties (data)
    
    var movies: [Movie] = Movie.dummyData
    private var filters: [String] = ["All", "Action", "Comedy", "Mystery"]
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "MovieOS"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        fetchMovies()
        setupCollectionView2()
        setupCollectionView()
        setupCollectionView3()
        
    }
    
    // MARK: - Set Up Views
    
    @objc private func fetchMovies() {
        NetworkManager.shared.fetchMovies { [weak self] movies in
            guard let self = self else { return }
            self.movies = movies
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            

            // Perform UI update on main queue
            // End of p3refreshControl.addTarget(self, action: **selector**, for: .valueChanged)
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuse)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            collectionView.topAnchor.constraint(equalTo: collectionView2.bottomAnchor, constant: 32),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func setupCollectionView2() {
        let filterlayout = UICollectionViewFlowLayout()
        filterlayout.scrollDirection = .horizontal
        filterlayout.minimumLineSpacing = 12
        
        collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: filterlayout)
        collectionView2.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuse)
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView2.alwaysBounceHorizontal = true
        
        
        
        
        view.addSubview(collectionView2)
        collectionView2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            collectionView2.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            collectionView2.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
        
    }
    
    @objc private func pushVC(movieName: String, movieDescription: String) {
        let viewController2 = SecondViewController(movieName: movieName, movieDescription: movieDescription)
        navigationController?.pushViewController(viewController2, animated: true)
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        let selectedFilter = filters[sender.tag]
        let selectedFilterIndex = sender.tag
        
        if selectedFilter == "All" {
            selectedGenre = nil
        } else {
            selectedGenre = selectedFilter
        }
        
        if selectedFilterIndex != self.selectedFilterIndex {
            if let currentCell = collectionView2.cellForItem(at: IndexPath(row: self.selectedFilterIndex, section: 0)) as? FilterCollectionViewCell {
                currentCell.isSelectedFilter = false
            }
            
            self.selectedFilterIndex = selectedFilterIndex
            
            if let selectedCell = collectionView2.cellForItem(at: IndexPath(row: selectedFilterIndex, section: 0)) as? FilterCollectionViewCell {
                selectedCell.isSelectedFilter = true
            }
        }
        
        collectionView.reloadData()
    }
    
    private func setupCollectionView3() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        
        collectionView3 = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView3.register(CreateMovieCollectionViewCell.self, forCellWithReuseIdentifier: CreateMovieCollectionViewCell.reuse)
        collectionView3.delegate = self
        collectionView3.dataSource = self
        view.addSubview(collectionView3)
        collectionView3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView3.leadingAnchor.constraint(equalTo: view.leadingAnchor), collectionView3.trailingAnchor.constraint(equalTo: view.trailingAnchor), collectionView3.topAnchor.constraint(equalTo: collectionView.bottomAnchor)])
    }

    

}

// MARK: - UICollectionView DataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuse, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let filteredMovies: [Movie]
            if let genre = selectedGenre {
                filteredMovies = movies.filter { $0.genre == genre }
            } else {
                filteredMovies = movies
            }
            cell.configure(movie: filteredMovies[indexPath.row])

            return cell
        }
        else if collectionView == self.collectionView2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuse, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(filterName: filters[indexPath.row], isSelected: indexPath.row == selectedFilterIndex, target: self, action: #selector(filterButtonTapped(_:)))
            cell.filterButton.tag = indexPath.row
        
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            if let genre = selectedGenre {
                return movies.filter { $0.genre == genre }.count
            } else {
                return movies.count
            }
        }
        else if collectionView == collectionView2 {
            return filters.count
        }
        return 0
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let width = collectionView.frame.width / 2 - 16
            
            return CGSize(width: width, height: 216)
        }
        else if collectionView == collectionView2 {
            return CGSize(width: 116, height:32)
        }
        return CGSize(width: 0, height: 0)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        pushVC(movieName: movie.name, movieDescription: movie.description)
        
        
        
    }
}
