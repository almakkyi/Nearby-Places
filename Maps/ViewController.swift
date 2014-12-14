//
//  ViewController.swift
//  Maps
//
//  Created by Ibrahim Almakky on 13/12/2014.
//  Copyright (c) 2014 Ibrahim Almakky. All rights reserved.
//

import UIKit

@objc
protocol ViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func collapseSidePanels()
}

class ViewController: UIViewController, GMSMapViewDelegate {
    
    var delegate: ViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var camera = GMSCameraPosition.cameraWithLatitude(37.80948,
            longitude:5.965699, zoom:2)
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        
        // Available map types: kGMSTypeNormal, kGMSTypeSatellite, kGMSTypeHybrid,
        // kGMSTypeTerrain, kGMSTypeNone
        
        // Set the mapType to Satellite
        mapView.mapType = kGMSTypeSatellite
        self.view = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Whent he menu button is pressed
    @IBAction func menuButton(sender: UIBarButtonItem) {
        delegate?.toggleLeftPanel?()
    }

}

