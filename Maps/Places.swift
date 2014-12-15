//
//  Places.swift
//  Maps
//
//  Created by Ibrahim Almakky on 15/12/2014.
//  Copyright (c) 2014 Ibrahim Almakky. All rights reserved.
//

import Foundation
import UIKit

struct place {
    var lat: Double
    var lon: Double
    var icon: UIImage
    var name: String
    var rating: Double
    var vicinity: String
}

class Places {
    class func searchNearby(lon: Double, lat: Double, category: String, completion: Array<place>->()) {
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lon),\(lat)&radius=50&types=\(category)&key=AIzaSyCh0jm-CxOgCyNFWBQRMIBjZUBIn5cPMWc")
        println(url)
        if let tempURL:NSURL = url {
            let urlReq = NSURLRequest(URL: tempURL)
            let queue = NSOperationQueue()
            NSURLConnection.sendAsynchronousRequest(urlReq, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if (error != nil) {
                    println("API error: \(error), \(error.userInfo)")
                }
                
                var jsonError:NSError?
                var json:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                if(jsonError != nil) {
                    println("Error parsing json: \(jsonError)")
                } else {
                    if let status:String = json["status"] as? String {
                        println("Server Status: \(status)")
                    }
                    
                    if let results: Array<AnyObject> = json["results"] as? Array<AnyObject> {
                        println(results)
                        var placesArray = [place]()
                        for result in results {
                            
                            var newPlace = place(lat: 0.0, lon: 0.0, icon: UIImage(), name: "", rating: 0.0, vicinity: "")
                            
                            if let geometry:NSDictionary  = result["geometry"] as? NSDictionary {
                                println(geometry)
                                if let location: NSDictionary = geometry["location"] as? NSDictionary {
                                    if let lat:Double = location["lat"] as? Double {
                                        println(lat)
                                        newPlace.lat = lat
                                    }
                                    if let lon:Double = location["lng"] as? Double {
                                        println(lon)
                                        newPlace.lon = lon
                                    }
                                }
                            }
                            
                            if let icon: String = result["icon"] as? String {
                                println(icon)
                                let iconURL = NSURL(string: icon)
                                if let iconData = NSData(contentsOfURL: iconURL!) {
                                    if let image:UIImage = UIImage(data: iconData) {
                                        newPlace.icon = image
                                    }
                                }
                            }
                            
                            if let name: String = result["name"] as? String {
                                println(name)
                                newPlace.name = name
                            }
                            
                            if let vicinity: String = result["vicinity"] as? String {
                                println(vicinity)
                                newPlace.vicinity = vicinity
                            }
                            placesArray.append(newPlace)
                        }
                        completion(placesArray)
                    }
                }
            })
        }
    }
}