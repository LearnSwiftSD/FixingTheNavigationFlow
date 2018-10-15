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

class ExSpeciesDetailViewController: UIViewController, ExSpeciesWidgetDataSource, ExSpeciesWidgetDelegate {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var extinctionDateLabel: UILabel!
    
    @IBOutlet weak var generalClassLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scientificNameLabel: UILabel!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        // ExSpecies widget embed segue.
        case "embedExSpeciesWidget":
            if let similarSpeciesWidget = segue.destination as? ExSpeciesWidgetViewController {
                similarSpeciesWidget.dataSource = self
                similarSpeciesWidget.delegate = self
            }
            
        // Show map.
        case "showMap":
            if let destinationNavVC = segue.destination as? UINavigationController,
                let mapVC = destinationNavVC.visibleViewController as? MapViewController,
                let habitat = exSpecies?.habitat[0] {
                mapVC.place = habitat
            }
            
        // Show note editor.
        case "showNote":
            if let destinationNavVC = segue.destination as? UINavigationController,
                let noteEditorVC = destinationNavVC.visibleViewController as? NoteEditorViewController
            {
                noteEditorVC.text = exSpecies?.notes
            }
            
        default:
            break
            
        }
    }
    
    @IBAction func selectSaveNote(segue: UIStoryboardSegue) {
        if let noteEditorVC = segue.source as? NoteEditorViewController,
            exSpecies != nil
        {
            exSpecies!.notes = noteEditorVC.text
            exSpeciesService.save(exSpecies!)
            updateViewFromData()
        }
    }
    
    // Show a new view that displays ExSpecies.
    func show(viewUsing exSpecies: ExSpecies) {
        guard let relatedExSpeciesDetailVC = storyboard?.instantiateViewController(withIdentifier: "exSpeciesDetailViewController") else { return }
        if let newSpeciesVC = relatedExSpeciesDetailVC as? ExSpeciesDetailViewController {
            newSpeciesVC.exSpecies = exSpecies
        }
        show(relatedExSpeciesDetailVC, sender: self)
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
