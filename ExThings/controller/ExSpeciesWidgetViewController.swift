//
//  ExSpeciesWidgetViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-08.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages a contained subview displaying tabular data for a set of ExSpecies.

import UIKit

class ExSpeciesWidgetViewController: UITableViewController {
    
    weak var dataSource: ExSpeciesWidgetDataSource?
    weak var delegate: ExSpeciesWidgetDelegate?
    
    private var widgetViewCellReuseID = "exSpeciesWidgetViewCell"

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return dataSource.widgetViewDataSource(self).isEmpty ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return dataSource.widgetViewDataSource(self).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let dataSource = dataSource else { return nil }
        return dataSource.widgetViewTitleForHeader(self)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: widgetViewCellReuseID, for: indexPath)

        cell.textLabel?.text = dataSource?.widgetViewDataSource(self)[indexPath.row].commonName

        return cell
    }
    
    // MARK: - Table view delegate interaction
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedExSpecies = dataSource?.widgetViewDataSource(self)[indexPath.row]
        if let selectedExSpecies = dataSource?.widgetViewDataSource(self)[indexPath.row] {
            delegate?.widgetView(self, didSelect: selectedExSpecies)
        }
    }

}

// MARK: - Data source protocol

protocol ExSpeciesWidgetDataSource: AnyObject {
    func widgetViewDataSource(_: ExSpeciesWidgetViewController) -> Array<ExSpecies>
    func widgetViewTitleForHeader(_: ExSpeciesWidgetViewController) -> String?
}

// Default implementation.
extension ExSpeciesWidgetDataSource {
    func widgetViewTitleForHeader(_: ExSpeciesWidgetViewController) -> String? {
        return nil
    }
}

// MARK: - Delegate protocol

protocol ExSpeciesWidgetDelegate: AnyObject {
    func widgetView(_: ExSpeciesWidgetViewController, didSelect exSpecies: ExSpecies)
}

// Default implementation.
extension ExSpeciesWidgetDelegate {
    func widgetView(_ widgetView: ExSpeciesWidgetViewController, didSelect exSpecies: ExSpecies) { }
}
