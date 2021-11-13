//
//  ArtData.swift
//  MetMobile
//
//  Created by Chakane Shegog on 11/12/21.
//

import Foundation

struct ArtCollection: Decodable {
    let primaryImage: String
    let primaryImageSmall: String
    let department: String
    let title: String
    let culture: String
    let objectDate: String
    let country: String
}
