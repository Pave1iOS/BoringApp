//
//  ColorViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 01.02.2024.
//

import UIKit

class ColorViewController: UIViewController {
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorCollectionView.dataSource = self
        
    }
}

extension ColorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "colorItem", for: indexPath)
        
        return item
    }
    
    
}
