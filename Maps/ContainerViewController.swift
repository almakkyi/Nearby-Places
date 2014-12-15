//
//  ContainerViewController.swift
//  Maps
//
//  Created by Ibrahim Almakky on 13/12/2014.
//  Copyright (c) 2014 Ibrahim Almakky. All rights reserved.
//

import UIKit
import QuartzCore

// This is used to keep track of the current state of the left menu
enum SlideOutState {
    case LeftPanelCollapsed
    case LeftPanelExpanded
}

class ContainerViewController: UIViewController, ViewControllerDelegate {
    
    var mainNavigationController: UINavigationController!
    var viewController: ViewController!
    
    // The current state is initialised with the menu panel collapsed
    var currentState: SlideOutState = .LeftPanelCollapsed
    var leftViewController: SideMenuViewController?
    
    // This value is the width of the main view controller that will be left visible (in points)
    var centerPanelExpandedOffset: CGFloat = 60

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
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
        showShadowForCenterViewController(notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        leftViewController = UIStoryboard.leftViewController()
        
        addChildSidePanelController(leftViewController!)
    }
    
    func addChildSidePanelController (sidePanelController: SideMenuViewController) {
        sidePanelController.delegate = viewController
        
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }

    func animateLeftPanel(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
        
            animateViewControllerXPosition(targetPosition: CGRectGetWidth(mainNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateViewControllerXPosition(targetPosition: 0) { finished in
                self.currentState = .LeftPanelCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
    }
    
    func animateViewControllerXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.mainNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow){
            mainNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            mainNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    // Gesture Recogniser
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
    }
    
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> SideMenuViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LeftViewController") as? SideMenuViewController
    }
    
    class func viewController() -> ViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("ViewController") as? ViewController
    }
}
