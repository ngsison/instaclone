//
//  CustomAccessoryView.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 29/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class CustomInputAccessoryView: UIView {
	override func didMoveToWindow() {
		super.didMoveToWindow()
		if let window = window {
			bottomAnchor.constraintLessThanOrEqualToSystemSpacingBelow(window.safeAreaLayoutGuide.bottomAnchor, multiplier: 1).isActive = true
		}
	}
}
