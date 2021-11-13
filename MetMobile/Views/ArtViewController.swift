//
//  ArtViewController.swift
//  MetMobile
//
//  Created by Chakane Shegog on 11/12/21.
//

import UIKit

class ArtViewController: UIViewController {
    @IBOutlet weak var artTitle: UILabel!
    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var detailImage: UIImageView!
    
    // set up random number for objectID
    override func viewDidLoad() {
        super.viewDidLoad()
        let objectID = Int.random(in: 1...80000)
        getNewArt(searchQuery: objectID)
  
    }
    @IBAction func generateNewArt(_ sender: UIButton!) {
        let objectID = Int.random(in: 1...80000)
        getNewArt(searchQuery: objectID)
    }
    
    func getNewArt(searchQuery: Int) {
        MetAPI.fetchArtCollection(for: searchQuery, completion: { [unowned self] (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let artCollection):
                DispatchQueue.main.async {
                    artTitle.text = "Title: \(artCollection.title)\nArtist: \(artCollection.artistDisplayName)\nCountry: \(artCollection.country)\nCulture: \(artCollection.culture)\nDepartment: \(artCollection.department)\nCreated: \(artCollection.objectDate)"
                    artImage.getImage(with: artCollection.primaryImage) { [weak self] (result) in
                        switch result {
                        case .failure:
                            DispatchQueue.main.async {
                                self?.artImage.image = UIImage(systemName: "exclamationmark.triangle")
                            }
                        case .success(let image):
                            DispatchQueue.main.async {
                                self?.artImage.image = image
                            }
                        }
                    }
                }
                
            }
        })
    }

}
