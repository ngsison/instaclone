//
//  LoginController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 25/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
	
	
	
	// MARK: - Properties
	let signupButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Don't have an account? Sign Up.", for: .normal)
		button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
		return button
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	
	
	// MARK: - Events
	@objc private func showSignUp() {
		let signupController = SignupController()
		self.navigationController?.pushViewController(signupController, animated: true)
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		self.view.backgroundColor = UIColor.white
		self.navigationController?.isNavigationBarHidden = true
		setupSignUpButton()
	}
	
	private func setupSignUpButton() {
		self.view.addSubview(signupButton)
		signupButton.anchor(bottom: self.view.bottomAnchor, equalTo: 8)
		signupButton.anchor(left: self.view.leftAnchor, equalTo: 8)
		signupButton.anchor(right: self.view.rightAnchor, equalTo: 8)
		signupButton.anchor(height: 50)
	}
}
