//
//  EndPoint.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//

import Foundation

enum EndPoint: EndPointProtocol {
    
    case character
    case singleCharacter(Int)
    
    var url: String {
        switch self {
        case .character:
            return "\(baseURL)/character"
        case .singleCharacter(let id):
            return "\(baseURL)/character/\(id)"
        }
    }
}
