//
//  NetworkError.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//

import Foundation

enum NetworkError: String {
    
    case badParsing
    case badURL
    case notInternet
    case unnowned
    case timeOUT
    
    var errorDescription: String {
        switch self {
        case .badParsing:
            "Bad Parsing"
        case .badURL:
            "Bad URL"
        case .notInternet:
            "Not Internet"
        case .unnowned:
            "Bilinmeyen"
        case .timeOUT:
            "TimeOut Xetasi"
        }
    }
}
