//
//  TypeViewController.swift
//  BoringApp
//
//  Created by Pavel Gribachev on 02.02.2024.
//

import UIKit

final class TypeViewController: UIViewController {
    
    @IBOutlet weak var activityTypeTableView: UITableView!
    
    private let activityTypes = TypeActivity.allCases
    var delegate: TypeViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        activityTypeTableView.dataSource = self
        activityTypeTableView.delegate = self
        activityTypeTableView.rowHeight = 85
    }
}

// MARK: TypeViewControllerDelegate
extension TypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.backType(activityTypes[indexPath.row].rawValue)
        dismiss(animated: true)
    }
}

// MARK: TypeViewControllerDataSource
extension TypeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activityTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath) as? CustomTableViewCell
        
        let activityType = activityTypes[indexPath.row].rawValue
        cell?.customLabel.text = activityType
                
        return cell ?? UITableViewCell()
    }
}
