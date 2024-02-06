//
//  ColorViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 01.02.2024.
//

import UIKit

final class ColorCollectionViewController: UICollectionViewController {
    
    let colors = ColorCollectionView.allCases
    var bgColor: UIColor!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)

        view.backgroundColor = UIColor(named: colors[indexPath.row].rawValue)
        dismiss(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorItem", for: indexPath) as? CustomCollectionViewCell
        let color = colors[indexPath.row]
        
        bgColor = UIColor(named: color.rawValue)
        
        cell?.customImageView.image = UIImage(named: color.rawValue)
        
        return cell ?? UICollectionViewCell()
    }
    
}


