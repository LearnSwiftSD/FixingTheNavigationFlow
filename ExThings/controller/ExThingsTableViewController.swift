//
//  ExThingsTableViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-03.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages a view presenting a list of all ExThings, grouped by type.

import UIKit

class ExThingsTableViewController: UITableViewController {
    
    // MARK: - Model - Services
    lazy var exPlacesService = (UIApplication.shared.delegate as! AppDelegate).exPlacesService
    lazy var exSpeciesService = (UIApplication.shared.delegate as! AppDelegate).exSpeciesService
    
    // All authoritative data, organized by group in the order desired for this view.
    var dataSource: Array<Array<ExThing>> {
        get {
            return [exPlaces, exSpecies]
        }
    }
    
    // Retrieve the latest authoritative exSpecies data.
    var exPlaces: Array<ExPlace> {
        get {
            return exPlacesService.exPlaces
        }
    }
    
    // Retrieve the latest authoritative exSpecies data.
    var exSpecies: Array<ExSpecies> {
        get {
            return exSpeciesService.exSpecies
        }
    }

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if dataSource[section] is Array<ExPlace> {
            return "Abandoned Places"
        } else {
            return "Extinct Species"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if dataSource[indexPath.section] is Array<ExPlace> {
            // exPlace
            cell = tableView.dequeueReusableCell(withIdentifier: "exPlaceTableViewCell", for: indexPath)
            cell.textLabel?.text = exPlaces[indexPath.item].name
        } else {
            // exSpecies
            cell = tableView.dequeueReusableCell(withIdentifier: "exSpeciesTableViewCell", for: indexPath)
            cell.textLabel?.text = exSpecies[indexPath.item].commonName
        }

        return cell
    }

    // MARK: - Navigation
    
    // Navigation stub for an unwind segue.
    @IBAction func goHome(segue: UIStoryboardSegue) {
        // Nothing needs doing, but it's good to be home.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {

        // Show ExPlace detail view.
        case "showExPlaceDetail":
            if let exPlaceDetailVC = segue.destination as? ExPlaceDetailViewController,
                let selectedIndex = tableView.indexPathForSelectedRow,
                dataSource[selectedIndex.section] is Array<ExPlace>
            {
                let selectedExPlace = exPlaces[selectedIndex.row]
                exPlaceDetailVC.exPlace = selectedExPlace
            }

        // Show ExSpecies detail view.
        case "showExSpeciesDetail":
            if let exSpeciesDetailViewController = segue.destination as? ExSpeciesDetailViewController,
                let selectedIndex = tableView.indexPathForSelectedRow,
                dataSource[selectedIndex.section] is Array<ExSpecies>
            {
                let selectedExSpecies = exSpecies[selectedIndex.row]
                exSpeciesDetailViewController.exSpecies = selectedExSpecies
            }

        default:
            break
        }

    }
    
}
