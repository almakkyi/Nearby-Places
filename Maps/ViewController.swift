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
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapCenterPinImage: UIImageView!
    @IBOutlet weak var pinImageVerticalConstraint: NSLayoutConstraint!
    
    var delegate: ViewControllerDelegate?
    
    let location = CLLocationManager()
    var lon:Double = 37.80948
    var lat:Double = 5.965699
    
    var threads: Int = 0
    
    // Array of places
    var nearbyPlaces:[place] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location //
        CLLocationManager.locationServicesEnabled()
        self.location.requestWhenInUseAuthorization()
        self.location.delegate = self
        self.location.distanceFilter = 20
        self.location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            location.startUpdatingLocation()
        
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("new location")
        if let loc = locations.last as? CLLocation {
            let latLon = loc.coordinate
            println("Lat: \(latLon.latitude), Lon: \(latLon.longitude)")
            if (lat != latLon.latitude && lon != latLon.longitude) {
                self.lat = latLon.latitude
                self.lon = latLon.longitude
                
                mapView.camera = GMSCameraPosition(target: latLon, zoom: 15, bearing: 0, viewingAngle: 0)
                
                location.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error")
    }
    
    func categorySelected(category: String) {
        println(category)
        
        delegate?.toggleLeftPanel?()
        
        self.getNearby()
    }
    
    func getNearby() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.threads++
        Places.searchNearby(51.50998, lat: -0.1337, category: "food", completion: {(result: Array<place>) in
            self.nearbyPlaces = result
            dispatch_async(dispatch_get_main_queue(), {
                self.setPins()
                self.threads--
                if(self.threads == 0) {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            })
        })
    }
    
    func setPins() {
        for place in nearbyPlaces {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(place.lat, place.lon)
            marker.appearAnimation = kGMSMarkerAnimationPop
            var imageView = UIImageView(frame: CGRectMake(5, 5, 5, 5))
            var image = place.icon
            imageView.image = image;
            marker.icon = image
            marker.map = mapView
            
            self.mapView.reloadInputViews()
        }
    }
    
    // Control the differne types of map views
    @IBAction func mapTypeSelected(sender: UISegmentedControl) {
        let segmentedControl = sender as UISegmentedControl
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                mapView.mapType = kGMSTypeNormal
            case 1:
                mapView.mapType = kGMSTypeSatellite
            case 2:
                mapView.mapType = kGMSTypeHybrid
            default:
                mapView.mapType = mapView.mapType
        }
    }
    
    // Whent he menu button is pressed
    @IBAction func menuButton(sender: UIBarButtonItem) {
        delegate?.toggleLeftPanel?()
    }
    
    // Saving Battery //
    
    override func viewWillAppear(animated: Bool) {
        self.location.startUpdatingLocation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.location.stopUpdatingLocation()
    }

}

