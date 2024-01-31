//
//  BoringViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 30.01.2024.
//

import UIKit

final class BoringViewController: UIViewController {

    @IBAction func boringButtonDidTapped(_ sender: UIButton) {
        fetchBoring()
    }
}

private extension BoringViewController {
    func fetchBoring() {
        URLSession.shared.dataTask(with: URL(string: "https://www.boredapi.com/api/activity/")!) { data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = try JSONDecoder().decode(Boring.self, from: data)
                
                print("DATA - \(decoder)")
                print("RESPONSE - \(response)")
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
