//
//  SlideInPushAnimator.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class SlideInPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private struct Constants {
        static let scaleFactor: CGFloat = 0.9
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        AnimationDuration.standard
    }

    /**
     TODO1: Place toVC outiside right, and transiton it in with easein, while transiton current vc out
        TODO2: Play around with timings and scale factor and/or rotations
     */

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                return
        }

        transitionContext.containerView.addSubview(toViewController.view)

        // Initial View Position
        let centerX = fromViewController.view.center.x
        let centerY = fromViewController.view.center.y

        let visibleFrame = fromViewController.view.frame
        toViewController.view.center = CGPoint(x: centerX + visibleFrame.size.width, y: centerY)
        toViewController.view.transform = toViewController.view.transform.scaledBy(x: Constants.scaleFactor, y: Constants.scaleFactor)


        let duration = self.transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {

            fromViewController.view.center = CGPoint(x: centerX + (visibleFrame.size.width * -1), y: centerY)
        })

        UIView.animate(withDuration: duration, delay: 0.1, options: [.curveEaseInOut], animations: {

            // Final View Position
            toViewController.view.center = CGPoint(x: centerX, y: centerY)
            toViewController.view.transform = CGAffineTransform.identity

        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })


    }

}
