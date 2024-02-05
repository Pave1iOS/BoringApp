//
//  NetworkManager.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 01.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchBoring(
        from url: URL,
        completion: @escaping(Result<Boring, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let boring = try JSONDecoder().decode(Boring.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(boring))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
            
        }.resume()
    }
}
