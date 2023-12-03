//
//  NetworkManager.swift
//  Hackathon
//
//  Created by Cole and Jamayne on 11/25/23.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    
    func fetchMovies(completion: @escaping ([Movie]) -> Void) {
        // Specify the endpoint
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // Only if needed
        
        let endpoint = "104.197.26.114:80/api/movies/"

        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Movie].self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let movies):
                    print("Successfully fetched \(movies.count) members")
                    completion(movies)
                case .failure(let error):
                    print("Error in NetworkManager.fetchMovies: \(error.localizedDescription)")
                }
            }
    }
    
    func addMovie(title: String, length: Int, genre: String, description: String, completion: @escaping (Movie) -> Void) {
        let parameters: Parameters = [
            "name": title,
            "length": length,
            "genre": genre,
            "description": description
        ]
        let endpoint = "104.197.26.114:80/api/movies/"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        AF.request(endpoint, method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of:Movie.self, decoder: decoder) { response in
                switch response.result {
                case .success(let movie):
                    print("Successfully added movie")
                    completion(movie)
                case .failure(let error):
                    print("Error in NetworkManager.addMovie: \(error.localizedDescription)")
                }
            }
    }
    
}
