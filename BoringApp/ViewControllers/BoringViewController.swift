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
    @IBOutlet weak var activityView: SpringView!
    
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
    
    @IBOutlet weak var nextButtonView: SpringView!
    
    // MARK: Properties
    private let networkManager = NetworkManager.shared
    private var type = "allTypes"
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomActivity()
    }
    
    // MARK: IBActions
    @IBAction func nextActivityDidTapped() {
        
        nextButtonView.animation = "pop"
        nextButtonView.curve = "easeOutCubic"
        nextButtonView.animate()
        
        fetchRandomActivity()
    }
    
    @IBAction func activityViewDidTapped() {
        activityView.animation = "morph"
        activityView.curve = "easeInCubic"
        activityView.animate()
        
        UIPasteboard.general.string = activityLabel.text
    }
    
    @IBAction func descriptionTranscriptDidTapped() {
        descriptionTranscriptView.animation = "squeezeDown"
        descriptionTranscriptView.animate()

        view.addSubview(descriptionTranscriptView)
        descriptionTranscriptButton.isHidden.toggle()
    }
    
    @IBAction func descriptionTranscriptViewCloseTapped() {
        descriptionTranscriptView.animation = "fadeOut"
        descriptionTranscriptView.animate()
    }
    
    // MARK: Prepare func
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let typeVC = segue.destination as? TypeViewController
        
        typeVC?.delegate = self
    }
}

// MARK: TypeViewControllerDelegate
extension BoringViewController: TypeViewControllerDelegate {
    func backType(_ type: String) {
        self.type = type
        fetchRandomActivity()
    }
}

// MARK: Fetch func
private extension BoringViewController {
    func fetchRandomActivity() {
        
        if TypeActivity.allTypes.rawValue == type {
            
            networkManager.fetchBoring(
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
        networkManager.fetchBoring(
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

