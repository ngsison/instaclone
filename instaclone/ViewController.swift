//
//  ViewController.swift
//  instaclone
//
//  Created by Nathaniel SISON on 14/8/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    
    // MARK: PROPERTIES
    let plusButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign Up", for: UIControlState.normal)
        button.backgroundColor = UIColor.rgb(149, 204, 244)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        button.addTarget(self, action: #selector(onSignUpButtonPress), for: UIControlEvents.touchUpInside)
        
        return button
    }()
    
    
    
    // MARK: OVERRIDES
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }


    
    // MARK: EVENTS
    @objc func onSignUpButtonPress() {
        
    }
}



// MARK: EXTENSION - SETUP VIEWS
extension ViewController {
    
    func setupViews() {
        setupPlusButton()
        setupInputFields()
    }
    
    private func setupPlusButton() {
        self.view.addSubview(plusButton)
        
        plusButton.anchor(height: 140)
        plusButton.anchor(width: 140)
        plusButton.anchor(centerX: self.view.centerXAnchor)
        plusButton.anchor(top: self.view.topAnchor, equalTo: 40)
    }
    
    private func setupInputFields() {
        let stackView = UIStackView()
        
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.spacing = 10
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signUpButton)
        
        self.view.addSubview(stackView)
        
        stackView.anchor(top: plusButton.bottomAnchor, equalTo: 20)
        stackView.anchor(left: self.view.leftAnchor, equalTo: 40)
        stackView.anchor(right: self.view.rightAnchor, equalTo: -40)
        stackView.anchor(height: 200)
    }
}

















