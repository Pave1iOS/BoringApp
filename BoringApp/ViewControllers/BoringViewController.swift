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
    
    @IBOutlet var copiedView: UIView! {
        didSet {
            copiedView.isHidden = true
        }
    }
    
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
    
    var bgColor: String!
    
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
        
        copiedView.isHidden.toggle()
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
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        view.backgroundColor = UIColor(hex: bgColor)
    }
    
    private func showAlert(withTitle title: String, andMassage massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okAction)
        present(alert, animated: true)
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
                    randomActivityPreset(boring)
                    print("DATA - \(boring)")
                case .failure(let failure):
                    showAlert(withTitle: "Oops...", andMassage: failure.localizedDescription)
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
                specificTypePreset(boring)
                print("DATA - \(boring)")
            case .failure(let failure):
                showAlert(withTitle: "Oops...", andMassage: failure.localizedDescription)
            }
        }
    }
}

// MARK: Preset views
private extension BoringViewController {
    func randomActivityPreset(_ boring: Boring) {
        activityIndicators.forEach { $0.stopAnimating() }
        activityLabel.text = boring.activity.uppercased()
        typeLabel.text = "type: \(boring.type.lowercased())"
        descriptionLabel.text = boring.description
        descriptionTranscriptLabel.text = boring.descriptionTranscript
        selectedTypeLabel.isHidden = true
        copiedView.isHidden = true
    }
    
    func specificTypePreset(_ boring: Boring) {
        activityIndicators.forEach { $0.stopAnimating() }
        activityLabel.text = boring.activity.uppercased()
        typeLabel.text = "type: \(boring.type.lowercased())"
        descriptionLabel.text = boring.description
        selectedTypeLabel.isHidden = false
        copiedView.isHidden = true
    }
}

