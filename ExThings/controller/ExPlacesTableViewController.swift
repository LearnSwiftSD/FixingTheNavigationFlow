//
//  ExPlacesTableViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-09.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages a view presenting a list of all ExPlaces.

import UIKit

class ExPlacesTableViewController: UITableViewController {
    
    // MARK: - Model - Services
    
    lazy var exPlacesService = (UIApplication.shared.delegate as! AppDelegate).exPlacesService
    lazy var exPlaces = exPlacesService.exPlaces
    
    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exPlaces.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Abandoned Places"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exPlaceTableViewCell", for: indexPath)
        cell.textLabel?.text = exPlaces[indexPath.item].name
        
        return cell
    }
    
    // MARK: - Navigation
    
    // Navigation stub for an unwind segue.
    @IBAction func goHome(segue: UIStoryboardSegue) {
        // No further action required.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let exPlaceDetailViewController = segue.destination as? ExPlaceDetailViewController,
            let selectedIndex = tableView.indexPathForSelectedRow {
            let selectedExPlace = exPlaces[selectedIndex.row]
            exPlaceDetailViewController.exPlace = selectedExPlace
        }
    }
    
}
