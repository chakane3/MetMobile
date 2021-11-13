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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewArt(searchQuery: 34574)
  
    }
    
    func getNewArt(searchQuery: Int) {
        MetAPI.fetchArtCollection(for: searchQuery, completion: { [unowned self] (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let artCollection):
                DispatchQueue.main.async {
                    artTitle.text = "Title: \(artCollection.title)\nArtist: \(artCollection.artistDisplayName)\nCountry: \(artCollection.country)\nCulture: \(artCollection.culture)\nDepartment: \(artCollection.department)\nCreated: \(artCollection.objectDate)"
                    
                }
                
            }
        })
    }

}
