//
//  SalesAnimationController.swift
//  Fripito
//
//  Created by Vladimír Bělohradský on 24/07/15.
//  Copyright © 2015 Fripito Corp. All rights reserved.
//

import UIKit
import QuartzCore

class SalesAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// transition is presenting new screen (true) or returning (false)
    var presenting = true
    
    init(presenting: Bool) {
        super.init()
        
        self.presenting = presenting
    }
    
    
    // MARK: - UIViewControllerAnimatedTransitioning methods
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)  {
        if presenting {
            animatePresentationWithTransitionContext(transitionContext)
        }
        else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    
    // MARK: - Helper methods
    
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()
        containerView?.addSubview(presentedControllerView)
        presentedControllerView.alpha = 0.0
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                presentedControllerView.alpha = 1.0
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
        })
        
    }
    
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let containerView = transitionContext.containerView()
        
        presentedControllerView.layer.zPosition = 1000
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            presentedControllerView.alpha = 0.0
            }) { (completed) -> Void in
                containerView?.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }
    
}
