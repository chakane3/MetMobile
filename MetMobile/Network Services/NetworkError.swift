//
//  NetworkError.swift
//  MetMobile
//
//  Created by Chakane Shegog on 11/12/21.
//

import Foundation

// we create a class to wrap around URLSession
class NetworkHelper {
    
    // create a shared instance of network helper
    static let shared = NetworkHelper()
    private var session: URLSession
    
    // we enforce singleton design by using a private init()
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with request: URLRequest, completion: @escaping (Result<Data, AppError>) -> ()) {
        let dataTask = session.dataTask(with: request) {(data, response, error) in
            
            // check for network client error
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            
            // downcast URLResponse (response) to HTTPURLResponse to get access to the status code property on HTTPURLResponse
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // unwrap the data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // validate that the status code is in the 200 range
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
