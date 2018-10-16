//
//  ExPlaceDetailViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-04.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages a view displaying data associated with a single ExPlace.

import UIKit

class ExPlaceDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var extinctionDateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nearestPlaceButton: UIButton!
    
    @IBOutlet weak var nearestSpeciesButton: UIButton!
    
    
    // MARK: - Model
    
    // Data service for accessing authoritative ExPlaces data.
    lazy var exPlacesService = (UIApplication.shared.delegate as! AppDelegate).exPlacesService
    
    // Data service for accessing authoritative ExSpecies data.
    lazy var exSpeciesService = (UIApplication.shared.delegate as! AppDelegate).exSpeciesService
    
    // ExPlace data displayed in this view.
    var exPlace: ExPlace? {
        didSet {
            if exPlace != nil {
                nearestExPlace = exPlacesService.findExPlace(nearest: exPlace!)
                nearestExSpecies = exSpeciesService.findExSpecies(nearest: exPlace!)
            }
            updateViewFromData()
        }
    }
    
    // The ExPlace nearest this ExPlace.
    var nearestExPlace: ExPlace?
    
    // The ExSpecies habitat nearest this ExPlace.
    var nearestExSpecies: ExSpecies?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewFromData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Rendering
    
    private func updateViewFromData() {
        guard let exPlace = exPlace else { return }
        
        self.title = exPlace.name
        
        if exPlace.notes != nil {
            descriptionTextView?.text = exPlace.description + "\n\n" + "Notes: " + String(exPlace.notes!)
        } else {
            descriptionTextView?.text = exPlace.description
        }
        
        extinctionDateLabel?.text = "abandoned in \(exPlace.extinctionDateAsString())"
        nearestPlaceButton?.setTitle(nearestExPlace!.name, for: .normal)
        nearestSpeciesButton?.setTitle(nearestExSpecies!.commonName, for: .normal)
        
        if let imageName = exPlace.image {
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
            
        // Show ExPlace detail view.
        case "showExPlaceDetail":
            (segue.destination.content as? ExPlaceConsumer)?.exPlace = nearestExPlace
            
        // Show ExSpecies detail view.
        case "showExSpeciesDetail":
            (segue.destination.content as? ExSpeciesConsumer)?.exSpecies = nearestExSpecies
            
        // Show map view.
        case "showMap":
            (segue.destination.content as? AnnotatedPlaceConsumer)?.annotatedPlace = nearestExPlace
            
        // Show note editor.
        case "showNote":
            (segue.destination.content as? TextConsumer)?.text = exPlace?.notes
            
        default:
            break
        }
    }
    
    @IBAction func selectSaveNote(segue: UIStoryboardSegue) {
        
        if let noteEditorVC = segue.source as? TextConsumer,
            exPlace != nil
        {
            exPlace!.notes = noteEditorVC.text
            exPlacesService.save(exPlace!)
            updateViewFromData()
        }
    }
    
}

extension ExPlaceDetailViewController: ExPlaceConsumer {}

extension ExPlaceDetailViewController: ExSpeciesConsumer {
    var exSpecies: ExSpecies? {
        get {
            return nearestExSpecies
        }
        set {
            // Do nothing. Shield internal data being set externally.
        }
    }
}

extension ExPlaceDetailViewController: ExThingConsumer {
    var exThing: ExThing? {
        get {
            return exPlace
        }
        set {
            if let newExPlace = newValue as? ExPlace {
                exPlace = newExPlace
            }
        }
    }
}
