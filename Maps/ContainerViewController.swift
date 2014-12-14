//
//  ContainerViewController.swift
//  Maps
//
//  Created by Ibrahim Almakky on 13/12/2014.
//  Copyright (c) 2014 Ibrahim Almakky. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController, ViewControllerDelegate {
    
    var mainNavigationController: UINavigationController!
    var viewController: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewController = UIStoryboard.viewController()
        viewController.delegate = self
        
        mainNavigationController = UINavigationController(rootViewController: viewController)
        view.addSubview(mainNavigationController.view)
        addChildViewController(mainNavigationController)
        
        mainNavigationController.didMoveToParentViewController(self)
    }
    
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

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> SideMenuViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("SideMenuViewController") as? SideMenuViewController
    }
    
    class func viewController() -> ViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("ViewController") as? ViewController
    }
}
