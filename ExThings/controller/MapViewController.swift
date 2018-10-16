//
//  MapViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-08.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

// Manages a view displaying a map.

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private enum Attribute {
        static let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    }
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsUserLocation = true
        }
    }
    
    var place: AnnotatedPlace? {
        didSet {
            // Add a new annotation to the queue based on this place.
            if let newAnnotation = place?.asMKPointAnnotation() {
                annotations.append(newAnnotation)
            }
            
            updateMapFromData()
        }
    }
    
    // A queue of annotations waiting to be added to the map view.
    private var annotations: [MKAnnotation] = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateMapFromData()
    }
    
    // MARK: - Interaction
    
    @IBAction func selectDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Rendering
    
    private func updateMapFromData() {
        updateMapAnnotations()
        updateMapRegion()
    }
    
    // Add any annotations to the map view and remove them from the annotations queue.
    private func updateMapAnnotations() {
        guard let mapView = mapView else { return }
        for annotation in annotations {
            mapView.addAnnotation(annotation)
        }
        annotations = []
    }
    
    // Update display region of the map view based on place data.
    private func updateMapRegion() {
        guard let mapView = mapView, let center = place?.coordinate else { return }
        mapView.region = MKCoordinateRegion(center: center, span: MapViewController.Attribute.span)
    }

}

extension MapViewController: AnnotatedPlaceConsumer {
    var annotatedPlace: AnnotatedPlace? {
        get {
            return place
        }
        set {
            place = newValue
        }
    }
}
