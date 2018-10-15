//
//  ExSpeciesTableViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-09.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages a view presenting a list of all ExSpecies.

import UIKit

class ExSpeciesTableViewController: UITableViewController {

    // MARK: - Model - Services
    
    lazy var exSpeciesService = (UIApplication.shared.delegate as! AppDelegate).exSpeciesService
    lazy var exSpecies = exSpeciesService.exSpecies
    
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
        return exSpecies.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Extinct Species"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exSpeciesTableViewCell", for: indexPath)
        cell.textLabel?.text = exSpecies[indexPath.item].commonName
        
        return cell
    }
    
    // MARK: - Navigation
    
    // Navigation stub for an unwind segue.
    @IBAction func goHome(segue: UIStoryboardSegue) {
        // No further questions at this time your honor.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let exSpeciesDetailViewController = segue.destination as? ExSpeciesDetailViewController,
            let selectedIndex = tableView.indexPathForSelectedRow {
            let selectedExSpecies = exSpecies[selectedIndex.row]
            exSpeciesDetailViewController.exSpecies = selectedExSpecies
        }
    }

}
