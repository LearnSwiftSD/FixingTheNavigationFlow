//
//  ExThingsTableViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages a view presenting a list of all ExThings, sectioned by type.

import UIKit

class ExThingsTableViewControllerV2: UITableViewController {
    
    // MARK: - Model - Services
    lazy var exThingsDataSource: Array<Array<ExThing>> = [exPlacesDataSource, exSpeciesDataSource]
    
    lazy var exPlacesService = (UIApplication.shared.delegate as! AppDelegate).exPlacesService
    lazy var exSpeciesService = (UIApplication.shared.delegate as! AppDelegate).exSpeciesService
    lazy var exPlacesDataSource = exPlacesService.exPlaces
    lazy var exSpeciesDataSource = exSpeciesService.exSpecies
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return exThingsDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exThingsDataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if exThingsDataSource[section] is Array<ExPlace> {
            return "Abandoned Places"
        } else {
            return "Extinct Species"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if exThingsDataSource[indexPath.section] is Array<ExPlace> {
            // exPlace
            cell = tableView.dequeueReusableCell(withIdentifier: "exPlaceTableViewCell", for: indexPath)
            cell.textLabel?.text = exPlacesDataSource[indexPath.item].name
        } else {
            // assume exSpecies
            cell = tableView.dequeueReusableCell(withIdentifier: "exSpeciesTableViewCell", for: indexPath)
            cell.textLabel?.text = exSpeciesDataSource[indexPath.item].commonName
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    // Navigation stub for an unwind segue.
    @IBAction func goHome(segue: UIStoryboardSegue) {
        // Nothing needs doing, but it's good to be home.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = sender as? UITableViewCell,
            let selectedIndex = tableView.indexPathForSelectedRow
        {
            let selectedExThing = exThingsDataSource[selectedIndex.section][selectedIndex.row]
            switch selectedExThing {
                
            // Show ExPlace detail view.
            case let selectedExPlace as ExPlace:
                (segue.destination as? ExPlaceDetailViewController)?.exPlace = selectedExPlace
                
            // Show ExSpecies detail view.
            case let selectedExSpecies as ExSpecies:
                (segue.destination as? ExSpeciesDetailViewController)?.exSpecies = selectedExSpecies
                
            default :
                break
            }
        }
    }
    
    
}
