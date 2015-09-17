//
//  SalesPresenterController.swift
//  Fripito
//
//  Created by Vladimír Bělohradský on 24/07/15.
//  Copyright © 2015 Fripito Corp. All rights reserved.
//

import UIKit

/**
    Presentation form that kinda copy sales view in iTunes store
*/
class SalesPresentationController: UIPresentationController {
    
    lazy var dimmingView: UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        view.alpha = 0.0
        return view
        }()
    
    
    override func presentationTransitionWillBegin() {
        let view = self.presentedView()
        view!.frame = self.frameOfPresentedViewInContainerView()
        
        // Add paralax effect
        let effectHorizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        effectHorizontal.maximumRelativeValue = 50
        effectHorizontal.minimumRelativeValue = -50
        view?.addMotionEffect(effectHorizontal)
        let effectVertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        effectVertical.maximumRelativeValue = 50
        effectVertical.minimumRelativeValue = -50
        view?.addMotionEffect(effectVertical)
        
        // Add the dimming view and the presented view to the heirarchy
        if let containerView = self.containerView {
            self.dimmingView.frame = containerView.bounds
            let gesture = UITapGestureRecognizer(target: presentedViewController, action: "performExit:")
            self.dimmingView.addGestureRecognizer(gesture)
            containerView.addSubview(self.dimmingView)
            containerView.addSubview(view!)
        }
        
        // Fade in the dimming view alongside the transition
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 1.0
                }, completion:nil)
        }
    }
    
    
    
    override func presentationTransitionDidEnd(completed: Bool) {
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    
    override func dismissalTransitionWillBegin()  {
        // Fade out the dimming view alongside the transition
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 0.0
                }, completion: {  (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            })
        }
    }
    
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        self.dimmingView.removeFromSuperview()
    }
    
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var frame = self.containerView!.bounds
        let center = CGPointMake(frame.width / 2, frame.height / 2)
        let smallerSide = frame.size.width > frame.size.height ? frame.size.height - 140 : frame.size.width  - 140
        frame = CGRectMake(center.x - (smallerSide / 2), center.y - (smallerSide / 2), smallerSide, smallerSide)
        return frame
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator transitionCoordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: transitionCoordinator)
        
        transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.frame = self.containerView!.bounds
            self.presentedView()?.frame = self.frameOfPresentedViewInContainerView()
        }, completion:nil)
    }
    
}
