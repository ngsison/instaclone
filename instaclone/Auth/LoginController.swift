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
	
	let logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
		imageView.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
		imageView.image = #imageLiteral(resourceName: "Instagram_logo_white")
		imageView.contentMode = .center
		return imageView
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
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
		setupLogo()
	}
	
	private func setupSignUpButton() {
		self.view.addSubview(signupButton)
		signupButton.anchor(bottom: self.view.bottomAnchor, equalTo: 8)
		signupButton.anchor(left: self.view.leftAnchor, equalTo: 8)
		signupButton.anchor(right: self.view.rightAnchor, equalTo: 8)
		signupButton.anchor(height: 50)
	}
	
	private func setupLogo() {
		self.view.addSubview(logoImageView)
		logoImageView.anchor(left: self.view.leftAnchor, equalTo: 0)
		logoImageView.anchor(right: self.view.rightAnchor, equalTo: 0)
		logoImageView.anchor(top: self.view.topAnchor, equalTo: 0)
		logoImageView.anchor(height: 150)
	}
}
