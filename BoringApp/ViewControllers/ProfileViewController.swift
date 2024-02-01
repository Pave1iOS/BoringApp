//
//  ProfileViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 01.02.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
    }

}

extension ProfileViewController: UITableViewDataSource {
    
    
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as? ColorTableViewCell
        
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    
}
