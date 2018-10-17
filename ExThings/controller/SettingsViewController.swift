//
//  SettingsViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-09.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages an application settings view.

import UIKit

class SettingsViewController: UITableViewController, Storyboarded {
    
    weak var delegate: SettingsViewControllerDelegate?
    
    @IBOutlet weak var navigationTableViewCell: UITableViewCell!
    
    @IBOutlet weak var splitViewTableViewCell: UITableViewCell!
    
    @IBOutlet weak var tabBarTableViewCell: UITableViewCell!
    
    let containerChoices = [Preferences.Container.navigationController,
                            Preferences.Container.splitViewController,
                            Preferences.Container.tabBarController]
    
    // MARK: - Lifecycle
    
    deinit {
        delegate?.removed(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedRow = containerChoices.firstIndex(of: Preferences.container) {
            selectRow(selectedRow)
        }
    }
    
    // MARK: - Interaction - table view
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(indexPath.row)
        switch indexPath.row {
        case 1:
            Preferences.container = .splitViewController
        case 2:
            Preferences.container = .tabBarController
        default:
            Preferences.container = .navigationController
        }
    }
    
    // MARK: - Rendering
    
    private func selectRow(_ row: Int) {
        navigationTableViewCell?.accessoryType = row == 0 ? .checkmark : .none
        splitViewTableViewCell?.accessoryType = row == 1 ? .checkmark : .none
        tabBarTableViewCell?.accessoryType = row == 2 ? .checkmark : .none
    }
    
    // MARK: - Interaction - general
    
    @IBAction func selectDone(_ sender: UIBarButtonItem) {
        dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            
            if let rootVC = self.storyboard?.instantiateViewController(withIdentifier: Preferences.container.asStoryboardID()) {
                UIApplication.shared.delegate?.window??.rootViewController = rootVC
            }
        }
    }

}

protocol SettingsViewControllerDelegate: AnyObject {
    func removed(_ settingsViewController: SettingsViewController)
}
