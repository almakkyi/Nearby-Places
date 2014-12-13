//
//  ViewController.swift
//  Maps
//
//  Created by Ibrahim Almakky on 13/12/2014.
//  Copyright (c) 2014 Ibrahim Almakky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GMSMapViewDelegate {

    var gmaps: GMSMapView?

    override func viewDidLoad() {
        super.viewDidLoad()

        var camera = GMSCameraPosition.cameraWithLatitude(-33.868,
            longitude:151.2086, zoom:6)
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        
        var marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = "Hello World"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        
        self.view = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

