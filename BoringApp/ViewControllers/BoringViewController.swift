//
//  BoringViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 30.01.2024.
//

import UIKit

protocol TypeViewControllerDelegate: AnyObject {
    func backType(_ type: String)
}

final class BoringViewController: UIViewController {
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var selectedTypeLabel: UIImageView! {
        didSet {
            selectedTypeLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionTranscriptView: UIView!
    
    @IBOutlet var activityIndicators: [UIActivityIndicatorView]!
    
    private let networkManager = NetworkManager.shared
    private var type = "allTypes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBoring()
    }
    
    // MARK: IBActions
    @IBAction func nextActivityDidTapped() {
        fetchBoring()
    }
    
    @IBAction func profileDidTapped() {
        
    }
    
    @IBAction func changeTypeDidTapped() {
       
    }
    
    @IBAction func descriptionTranscriptDidTapped() {
        
        descriptionTranscriptView.isHidden.toggle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let typeVC = segue.destination as? TypeViewController
        
        typeVC?.delegate = self
    }
}

// MARK: TypeViewControllerDelegate
extension BoringViewController: TypeViewControllerDelegate {
    func backType(_ type: String) {
        self.type = type
        fetchBoring()
    }
}

// MARK: Fetch func
private extension BoringViewController {
    func fetchBoring() {
        
        if TypeActivity.allTypes.rawValue == type {
            
            networkManager.fetch(
                Boring.self,
                from: URL(
                    string: Link.boredURL.url
                )!
            ) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let boring):
                    activityIndicators.forEach { $0.stopAnimating() }
                    activityLabel.text = boring.activity.uppercased()
                    typeLabel.text = "type: \(boring.type.lowercased())"
                    descriptionLabel.text = boring.description
                    selectedTypeLabel.isHidden = true
                    print("DATA - \(boring)")
                case .failure(let failure):
                    print(failure)
                }
            }
        } else {
            fetchSpecificType()
        }
    }
    
    func fetchSpecificType() {
        networkManager.fetch(
            Boring.self,
            from: URL(
                string: Link.activityTypeURL.url + type
            )!
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let boring):
                activityIndicators.forEach { $0.stopAnimating() }
                activityLabel.text = boring.activity.uppercased()
                typeLabel.text = "type: \(boring.type.lowercased())"
                descriptionLabel.text = boring.description
                selectedTypeLabel.isHidden = false
                print("DATA - \(boring)")
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

