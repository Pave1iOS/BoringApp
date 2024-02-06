//
//  SettingsViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 07.02.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
        settingsTableView.rowHeight = 60
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? CustomTableViewCell
        cell?.customLabel.text = "Set color"
        
        return cell ?? UITableViewCell()
    }
}
