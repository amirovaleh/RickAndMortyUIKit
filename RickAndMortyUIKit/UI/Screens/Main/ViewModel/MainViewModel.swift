//
//  MainViewModel.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func didSuccess()
}

final class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    private var http: HTTPClientProtocol
    
    private var characterData: MainModel = MainModel(results: []) {
        didSet {
            filteredData = characterData.results
                delegate?.didSuccess()
        }
    }
    
    var filteredData: [Results] = []
    
    init(http: HTTPClientProtocol) {
        self.http = http
    }
    
    
    func fetchData() {
        http.request(endPoint: .character, method: .GET) { (data: MainModel? , error: NetworkError?) in
            if let error {
                print(error.errorDescription)
            }
            if let data {
                DispatchQueue.main.async {
                    self.characterData = data
                }
            }
        }
    }
    
    func search(nameText: String) {
        if !nameText.isEmpty {
            filteredData.removeAll()
            characterData.results.forEach { result in
                guard let name = result.name else { return }
                if name.lowercased().contains(nameText.lowercased()) {
                    filteredData.append(result)
                }
            }
        } else {
            filteredData = characterData.results
        }
        delegate?.didSuccess()
    }
}
