//
//  MainModel.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//
//

import Foundation

struct MainModel: Codable {
    let results: [Results]
}

struct Results: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}
