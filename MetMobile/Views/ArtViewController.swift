//
//  ArtViewController.swift
//  MetMobile
//
//  Created by Chakane Shegog on 11/12/21.
//

import UIKit

class ArtViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MetAPI.fetchArtCollection(for: [546, 346, 4576, 25, 3675, 44], completion: {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("app error")
            case .success(let recipes):
                print(recipes)
            }
        })
        // Do any additional setup after loading the view.
    }
    

  

}
