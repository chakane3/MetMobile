//
//  MetAPI.swift
//  MetMobile
//
//  Created by Chakane Shegog on 11/12/21.
//

import Foundation

struct MetAPI {
    // this function takes in an array on random objectID's
    static func fetchArtCollection(for searchQuery: Int, completion: @escaping (Result<Art, AppError>) -> ()) {
        //let searchQuery = searchquery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "or not thats fine too"

        // use string interpolation to build our custom endpoint URL
        let metEndpoint = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(searchQuery)"
            
        // create a url from our endpoint
        guard let url = URL(string: metEndpoint) else {
            completion(.failure(.badURL(metEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        
        // make our network request to the endpoint
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResuls = try JSONDecoder().decode(Art.self, from: data)
                    
                    // create an array out of the result
                    let art = searchResuls
                    
                    completion(.success(art))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
