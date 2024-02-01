//
//  BoringViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 30.01.2024.
//

import UIKit

final class BoringViewController: UIViewController {
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBoring()
    }
    
    @IBAction func nextActivityDidTapped() {
        fetchBoring()
    }
    
    @IBAction func profileDidTapped() {
        
    }
    
    
}

private extension BoringViewController {
    func fetchBoring() {
        networkManager.fetch(
            Boring.self,
            from: URL(
                string: "https://www.boredapi.com/api/activity/"
            )!
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let boring):
                activityIndicator.stopAnimating()
                print(boring)
                activityLabel.text = boring.activity.uppercased()
                descriptionLabel.text = boring.description.lowercased()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
