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
    
    // set up random number for objectID
    override func viewDidLoad() {
        super.viewDidLoad()
        let objectID = Int.random(in: 1...90000)
        getNewArt(searchQuery: objectID)
  
    }
    @IBAction func generateNewArt(_ sender: UIButton!) {
        let objectID = Int.random(in: 1...90000)
        getNewArt(searchQuery: objectID)
    }
    
    func getNewArt(searchQuery: Int) {
        MetAPI.fetchArtCollection(for: searchQuery, completion: { [unowned self] (result) in
            switch result {
            case .failure(let _):
                getNewArt(searchQuery: Int.random(in: 1...90000))
            case .success(let artCollection):
                DispatchQueue.main.async {
                    artTitle.text = "Title: \(artCollection.title)\nArtist: \(artCollection.artistDisplayName)\nCountry: \(artCollection.country)\nCulture: \(artCollection.culture)\nDepartment: \(artCollection.department)\nCreated: \(artCollection.objectDate)"
                    artImage.getImage(with: artCollection.primaryImage) { [weak self] (result) in
                        switch result {
                        case .failure:
                            // img error
                            getNewArt(searchQuery: Int.random(in: 1...90000))
                        case .success(let image):
                            DispatchQueue.main.async {
                                self?.artImage.image = image
                                print("IMAGE --> \(image)\nobjectID --> \(searchQuery)")
                            }
                        }
                    }
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else {
            fatalError("could not get an instance of DVC")
        }
        detailVC.artImg = artImage
    }
}
