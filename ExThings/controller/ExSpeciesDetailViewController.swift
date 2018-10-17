//
//  ExSpeciesDetailViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-07.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages a view displaying data for a single ExSpecies.
// Some relational data is also presented.

import UIKit

class ExSpeciesDetailViewController: DelegatedSegueViewController, ExSpeciesWidgetDataSource, ExSpeciesWidgetDelegate {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var extinctionDateLabel: UILabel!
    
    @IBOutlet weak var generalClassLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scientificNameLabel: UILabel!
    
    var navigator: ExSpeciesDetailNavigator?
    
    // MARK: - Model
    
    // Data service for accessing authoritative ExSpecies data.
    lazy var exSpeciesService = (UIApplication.shared.delegate as! AppDelegate).exSpeciesService
    
    // Tracks selected similar species.
    var selectedSimilarSpecies: ExSpecies?
    
    // ExSpecies data displayed in this view.
    var exSpecies: ExSpecies? {
        didSet {
            // Refresh the view to reflect data changes.
            updateViewFromData()
            // Recalculate similarSpecies.
            similarSpecies = exSpecies == nil ? [] : exSpeciesService.findExSpecies(matchingGeneralClass: exSpecies!.generalClass, excepting: [exSpecies!], limitedTo: 3)
        }
    }
    
    // A short list of some species sharing the same generalClass as exSpecies.
    var similarSpecies: [ExSpecies] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // kludge - This is an anti-pattern: bastard injection
        navigator = ExSpeciesDetailNavigator()
        segueDelegate = navigator

        updateViewFromData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Rendering
    
    func updateViewFromData() {
        guard let exSpecies = exSpecies else { return }
        
        self.title = exSpecies.commonName
        scientificNameLabel?.text = "Scientific Name: \(exSpecies.scientificName)"
        generalClassLabel?.text = "Class: \(exSpecies.generalClass)"
        
        if exSpecies.notes != nil {
            descriptionTextView?.text = exSpecies.description + "\n\n" + "Notes: " + String(exSpecies.notes!)
        } else {
            descriptionTextView?.text = exSpecies.description
        }
        
        extinctionDateLabel?.text = "extinct by \(exSpecies.extinctionDateAsString())"
        
        if let imageName = exSpecies.image {
            if let image = UIImage(named: imageName) {
                imageView?.image = image
                imageView?.isHidden = false
            } else {
                imageView?.isHidden = true
            }
        }
    }

    // MARK: - Navigation
    
    // This is the "first responder" to the prepare(for:sender:) call.
    // important - The segueDelegate does not receive embed segues!
    // kludge - We override the super implementation here to intercept the "embedExSpeciesWidget" embed segue.
    // All other segues are handled by the parent class.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
            // ExSpecies widget embed segue.
        // This must be handled here.
        case "embedExSpeciesWidget":
            if let similarSpeciesWidget = segue.destination as? ExSpeciesWidgetViewController {
                similarSpeciesWidget.dataSource = self
                similarSpeciesWidget.delegate = self
            }
            
        // Let the DelegatedSegueViewController super class handle everything else (which sends the call to the segueDelegate implementation).
        default:
            super.prepare(for: segue, sender: sender)
            
        }
    }
    
    // Show a new view that displays ExSpecies.
    func show(viewUsing exSpecies: ExSpecies) {
        navigator?.navigate(to: .exSpeciesView(exSpecies: exSpecies), from: self)
    }
    
    // MARK: - ExSpecies widget data source
    
    func widgetViewDataSource(_: ExSpeciesWidgetViewController) -> Array<ExSpecies> {
        return similarSpecies
    }
    
    func widgetViewTitleForHeader(_: ExSpeciesWidgetViewController) -> String? {
        return exSpecies == nil ? nil : "other extinct \(exSpecies!.generalClass.stringPlural())"
    }
    
    // MARK: - ExSpecies widget delegate
    
    func widgetView(_ widgetView: ExSpeciesWidgetViewController, didSelect exSpecies: ExSpecies) {
        show(viewUsing: exSpecies)
    }
    
}

extension ExSpeciesDetailViewController: ExSpeciesConsumer {}

extension ExSpeciesDetailViewController: ExThingConsumer {
    var exThing: ExThing? {
        get {
            return exSpecies
        }
        set {
            if let newExSpecies = newValue as? ExSpecies {
                exSpecies = newExSpecies
            }
        }
    }
}
