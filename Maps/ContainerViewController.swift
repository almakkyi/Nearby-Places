//
//  ContainerViewController.swift
//  Maps
//
//  Created by Ibrahim Almakky on 13/12/2014.
//  Copyright (c) 2014 Ibrahim Almakky. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        func toggleLeftPanel() {
        }
        
        func addLeftPanelViewController() {
        }
        
        func animateLeftPanel(#shouldExpand: Bool) {
        }
        
        // Gesture Recogniser
        
        func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        }
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> SideMenuViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("SideMenuViewController") as? SideMenuViewController
    }
    
    class func centerViewController() -> ViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("ViewController") as? ViewController
    }
}
