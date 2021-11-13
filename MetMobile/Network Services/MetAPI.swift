//
//  MetAPI.swift
//  MetMobile
//
//  Created by Chakane Shegog on 11/12/21.
//

import Foundation

struct MetAPI {
    static func fetchArtCollection(for searchquery: String, completion: @escaping (Result<[ArtCollection], AppError>) -> ()) {
        //let searchQuery = searchquery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "or not thats fine too"
        
        // use string interpolation to build our custom endpoint URL
        let metEndpoint = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(searchquery)"
        
    }
}
