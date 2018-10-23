//
//  LoginController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 25/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
	
	
	
	// MARK: - Properties
	let showSignupButton: UIButton = {
		let button = UIButton(type: .system)

		var attributedTitle = NSMutableAttributedString(attributedString: NSAttributedString(string: "Don't have an account? ", attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
			NSAttributedStringKey.foregroundColor: UIColor.lightGray
		]))
		
		attributedTitle.append(NSAttributedString(string: "Sign Up.", attributes: [
			NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14),
			NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)
		]))

		button.setAttributedTitle(attributedTitle, for: .normal)
		button.addTarget(self, action: #selector(onShowSignupButtonPress), for: .touchUpInside)
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
	
	let emailTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Email"
		tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
		tf.borderStyle = UITextBorderStyle.roundedRect
		tf.font = UIFont.systemFont(ofSize: 14)
		tf.autocapitalizationType = UITextAutocapitalizationType.none
		tf.autocorrectionType = UITextAutocorrectionType.no
		tf.addTarget(self, action: #selector(onTextInputChanged), for: UIControlEvents.editingChanged)
		return tf
	}()
	
	let passwordTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Password"
		tf.isSecureTextEntry = true
		tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
		tf.borderStyle = UITextBorderStyle.roundedRect
		tf.font = UIFont.systemFont(ofSize: 14)
		tf.autocapitalizationType = UITextAutocapitalizationType.none
		tf.autocorrectionType = UITextAutocorrectionType.no
		tf.addTarget(self, action: #selector(onTextInputChanged), for: UIControlEvents.editingChanged)
		return tf
	}()
	
	let loginButton: UIButton = {
		let button = UIButton(type: UIButtonType.system)
		button.setTitle("Log In", for: UIControlState.normal)
		button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
		button.layer.cornerRadius = 5
		button.layer.masksToBounds = true
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.setTitleColor(UIColor.white, for: UIControlState.normal)
		button.isEnabled = false
		button.addTarget(self, action: #selector(onLoginButtonPress), for: UIControlEvents.touchUpInside)
		
		return button
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.hideKeyboardWhenTappedAround()
		setupViews()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	
	
	// MARK: - Events
	@objc private func onShowSignupButtonPress() {
		let signupController = SignupController()
		self.navigationController?.pushViewController(signupController, animated: true)
	}
	
	@objc private func onTextInputChanged() {
		let emailIsValid = emailTextField.text!.count > 0
		let passwordIsValid = passwordTextField.text!.count > 0
		
		if emailIsValid && passwordIsValid {
			loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
			loginButton.isEnabled = true
		}
		else {
			loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
			loginButton.isEnabled = false
		}
	}
	
	@objc private func onLoginButtonPress() {
		guard
			let email = emailTextField.text, email.count > 0,
			let password = passwordTextField.text, password.count > 0
		else { return }
		
		Auth.auth().signIn(withEmail: email, password: password) { (result: AuthDataResult?, error: Error?) in
			if let error = error {
				print("Error signing in: \(error)")
				return
			}
			
			print("Successfully signed in")
			guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
			mainTabBarController.showMainTabs()
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		self.view.backgroundColor = UIColor.white
		self.navigationController?.isNavigationBarHidden = true
		setupShowSignupButton()
		setupLogo()
		setupInputFields()
	}
	
	private func setupShowSignupButton() {
		self.view.addSubview(showSignupButton)
		showSignupButton.anchor(bottom: self.view.bottomAnchor, equalTo: 0)
		showSignupButton.anchor(left: self.view.leftAnchor, equalTo: 8)
		showSignupButton.anchor(right: self.view.rightAnchor, equalTo: 8)
		showSignupButton.anchor(height: 50)
	}
	
	private func setupLogo() {
		self.view.addSubview(logoImageView)
		logoImageView.anchor(left: self.view.leftAnchor, equalTo: 0)
		logoImageView.anchor(right: self.view.rightAnchor, equalTo: 0)
		logoImageView.anchor(top: self.view.topAnchor, equalTo: 0)
		logoImageView.anchor(height: 150)
	}
	
	private func setupInputFields() {
		let stackView = UIStackView()
		
		stackView.distribution = UIStackViewDistribution.fillEqually
		stackView.axis = UILayoutConstraintAxis.vertical
		stackView.spacing = 10
		
		stackView.addArrangedSubview(emailTextField)
		stackView.addArrangedSubview(passwordTextField)
		stackView.addArrangedSubview(loginButton)
		
		self.view.addSubview(stackView)
		
		stackView.anchor(top: logoImageView.bottomAnchor, equalTo: 40)
		stackView.anchor(left: self.view.leftAnchor, equalTo: 40)
		stackView.anchor(right: self.view.rightAnchor, equalTo: 40)
		stackView.anchor(height: 140)
	}
}
