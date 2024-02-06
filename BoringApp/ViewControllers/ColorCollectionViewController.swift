//
//  ColorCollectionViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 07.02.2024.
//

import UIKit

class ColorCollectionViewController: UICollectionViewController {
    
    let colors = BackgraundColors.allCases
    var bgColorName: String!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorItem", for: indexPath) as? CustomCollectionViewCell
        let color = colors[indexPath.row].rawValue
        cell?.customImageView.image = UIImage(named: color)
        
        return cell ?? UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bgColorName = colors[indexPath.row].rawValue
        guard let color = bgColorName else { return }
        
        print(color)
        
        dismissTo(vcCount: 2, animated: true)
    }
}

private extension UIViewController {
    func dismissTo(vcCount count: Int, animated: Bool) {
        var dummyVC: UIViewController? = self
        
        for _ in 0..<count {
            dummyVC = dummyVC?.presentingViewController
        }
        
        if count != 0 {
            dummyVC?.dismiss(animated: animated)
        }
    }
}
