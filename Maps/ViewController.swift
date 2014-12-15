//
//  ViewController.swift
//  Maps
//
//  Created by Ibrahim Almakky on 13/12/2014.
//  Copyright (c) 2014 Ibrahim Almakky. All rights reserved.
//

import UIKit
import CoreLocation

@objc
protocol ViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func collapseSidePanels()
}

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, SidePanelViewControllerDelegate {
    
    var delegate: ViewControllerDelegate?
    
    let location = CLLocationManager()
    var lon:Double = 37.80948
    var lat:Double = 5.965699
    
    // Google Maps
    var camera = GMSCameraPosition()
    var mapView = GMSMapView()
    var marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location //
        CLLocationManager.locationServicesEnabled()
        self.location.requestWhenInUseAuthorization()
        self.location.delegate = self
        self.location.distanceFilter = 20
        self.location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.location.startUpdatingLocation()
        
        self.showMap(lon, lat: lat)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("new location")
        if let loc = locations.last as? CLLocation {
            let latLon = loc.coordinate
            println("Lat: \(latLon.latitude), Lon: \(latLon.longitude)")
            if (lat != latLon.latitude && lon != latLon.longitude) {
                self.lat = latLon.latitude
                self.lon = latLon.longitude
                
                self.showMap(latLon.latitude, lat: latLon.longitude)
                self.setCurrentPin(latLon.latitude, lat: latLon.longitude)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error")
    }
    
    func showMap(lon: Double, lat: Double) {
        // Goolge Maps //
        self.camera = GMSCameraPosition.cameraWithLatitude(lon, longitude:lat, zoom:15)
        self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        
        // Available map types: kGMSTypeNormal, kGMSTypeSatellite, kGMSTypeHybrid,
        // kGMSTypeTerrain, kGMSTypeNone
        
        // Set the mapType to Satellite
        mapView.mapType = kGMSTypeSatellite
        self.view = mapView
    }
    
    func setCurrentPin(lon: Double, lat: Double) {
        self.marker.position = camera.target
        
        marker.snippet = "Current"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
    }
    
    func categorySelected(category: String) {
        println(category)
        
        delegate?.toggleLeftPanel?()
    }
    
    func getNearby() {
        
    }
    
    // Whent he menu button is pressed
    @IBAction func menuButton(sender: UIBarButtonItem) {
        delegate?.toggleLeftPanel?()
    }

}

