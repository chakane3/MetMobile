//
//  ImageClient_Extension.swift
//  MetMobile
//
//  Created by Chakane Shegog on 11/13/21.
//

import UIKit

// we are creating an extension on UIImageView to handoff getting a
// UIImage using our URLSession wrapper class (NetworkHelper)
extension UIImageView {
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        // implement UIActivityIndicatorView to indicate to the user a download is in progress
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.startAnimating()
        activityIndicator.center = center
        addSubview(activityIndicator)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { [weak activityIndicator] (result) in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
}
