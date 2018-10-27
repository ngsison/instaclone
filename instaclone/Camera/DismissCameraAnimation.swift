//
//  DismissCameraAnimation.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 27/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class DismissCameraAnimation: NSObject, UIViewControllerAnimatedTransitioning {
	
	private let animationDuration = 0.75
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return animationDuration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let containerView = transitionContext.containerView
		
		// from = CameraController
		// to 	= OtherController
		guard
			let fromView = transitionContext.view(forKey: .from),
			let toView = transitionContext.view(forKey: .to)
		else { return }
		
		containerView.addSubview(fromView)
		containerView.addSubview(toView)
		
		// from animation = center going left
		// to	animation = right going center
		
		fromView.frame = CGRect(x: 0, y: 0, width: fromView.frame.width, height: fromView.frame.height)
		toView.frame = CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
		
		UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
			fromView.frame = CGRect(x: -fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height)
			toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
		}) { (completed) in
			transitionContext.completeTransition(true)
		}
	}
}
