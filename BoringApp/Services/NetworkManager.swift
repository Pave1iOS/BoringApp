//
//  NetworkManager.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 01.02.2024.
//

import Foundation
import Alamofire

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchBoring(
        from url: URL,
        completion: @escaping(Result<Boring, AFError>) -> Void
    ) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let boring = Boring.getBoring(from: value)
                    completion(.success(boring))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
