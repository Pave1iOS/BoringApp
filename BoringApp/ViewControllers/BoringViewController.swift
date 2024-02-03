//
//  BoringViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 30.01.2024.
//

import UIKit
import SpringAnimation

protocol TypeViewControllerDelegate: AnyObject {
    func backType(_ type: String)
}

final class BoringViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var selectedTypeLabel: UIImageView! {
        didSet {
            selectedTypeLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionTranscriptButton: UIView!
    @IBOutlet weak var descriptionTranscriptView: SpringView! {
        didSet {
            descriptionTranscriptView.center = view.center
        }
    }
    @IBOutlet weak var descriptionTranscriptLabel: UILabel!

    @IBOutlet var activityIndicators: [UIActivityIndicatorView]!
    
    // MARK: Properties
    private let networkManager = NetworkManager.shared
    private var type = "allTypes"
    
    // MARK: viewDidLoad
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
        animateIn(view: descriptionTranscriptView)
        descriptionTranscriptButton.isHidden.toggle()
    }
    
    @IBAction func descriptionTranscriptViewCloseTapped() {
        animateOut(view: descriptionTranscriptView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let typeVC = segue.destination as? TypeViewController
        
        typeVC?.delegate = self
    }
}

// MARK: Animation func
private extension BoringViewController {
    func animateIn(view: SpringView) {
        view.animation = "squeezeDown"
        view.animate()
        
        self.view.addSubview(view)
    }
    
    func animateOut(view: SpringView) {
        descriptionTranscriptView.animation = "fadeOut"
        descriptionTranscriptView.animate()
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
                    descriptionTranscriptLabel.text = boring.descriptionTranscript
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

