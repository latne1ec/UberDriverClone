//
//  DriverVC.swift
//  Uber Driver
//
//  Created by Evan Latner on 4/17/17.
//  Copyright © 2017 levellabs. All rights reserved.
//

import UIKit
import MapKit

class DriverVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    private var locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    private var riderLocation: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
    }
    
    private func initLocationManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // If we have coords
        if let location = locationManager.location?.coordinate {
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            map.setRegion(region, animated: true)
            map.removeAnnotation(map.annotations as! MKAnnotation)
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation!
            annotation.title = "Driver Location"
            map.addAnnotation(annotation)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logout() {
            dismiss(animated: true, completion: nil)
        } else {
            // problem occured
        }
    }
    @IBAction func cancelRide(_ sender: Any) {
    }
}
