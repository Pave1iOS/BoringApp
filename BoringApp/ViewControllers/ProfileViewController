//
//  ProfileViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 01.02.2024.
//

import UIKit

final class ProfileViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.dataSource = self
        settingsTableView.rowHeight = 85
        
    }

}

// MARK: ProfileViewControllerDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as? CustomTableViewCell
        cell?.customLabel.text = "Change color"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
}
