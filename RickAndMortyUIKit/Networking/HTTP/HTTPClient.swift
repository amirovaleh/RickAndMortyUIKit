//
//  HTTPClient.swift
//  RickAndMortyUIKit
//
//  Created by Valeh Amirov on 27.02.24.
//

import Foundation

protocol HTTPClientProtocol: AnyObject {
    func request<T: Decodable>(endPoint: EndPoint ,method: HTTPMethod, completion: @escaping(T?, NetworkError?) -> Void)
}

class HTTPClient: HTTPClientProtocol {
    
    func request<T: Decodable>(endPoint: EndPoint ,method: HTTPMethod, completion: @escaping(T?, NetworkError?) -> Void) {
        
        guard let url = URL(string: endPoint.url) else {
            completion(nil, .badURL)
            print(endPoint.url)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 60
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                completion(nil, .unnowned)
                print(error.localizedDescription)
                
                if let urlError = error as? URLError {
                    if urlError.code == .timedOut {
                        completion(nil, .timeOUT)
                    } else if urlError.code == .notConnectedToInternet {
                        completion(nil, .notInternet)
                    } else if urlError.code == .badURL {
                        completion(nil, .badURL)
                    }
                }
            }
            
            guard let data else { return }
            
            do {
                let decode = try JSONDecoder().decode(T.self, from: data)
                completion(decode, nil)
            } catch {
                completion(nil, .badParsing)
                print(error)
            }
        }
        .resume()
    }
}
