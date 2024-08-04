//
//  DetailViewModel.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func didSuccess()
}

final class DetailViewModel {
    
    weak var delegate: DetailViewModelDelegate?
    
    private var http: HTTPClientProtocol
    
    init(http: HTTPClientProtocol) {
        self.http = http
    }
    
     var userData: Results? {
        didSet {
            delegate?.didSuccess()
        }
    }
    
    func update(id: Int) {
    http.request(endPoint: .singleCharacter(id), method: .GET) { (data: Results? , error: NetworkError?) in
            if let error {
                print(error.errorDescription)
            }
            if let data {
                DispatchQueue.main.async {
                    self.userData = data
                }
            }
        }
    }
}
