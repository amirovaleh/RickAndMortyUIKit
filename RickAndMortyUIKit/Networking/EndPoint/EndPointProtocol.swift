//
//  EndPointProtocol.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: String { get }
}

extension EndPointProtocol {
    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }
}
