//
//  ViewController.swift
//  instaclone
//
//  Created by Nathaniel SISON on 14/8/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    // MARK: PROPERTIES
    let plusButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
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
        return button
    }()
    
    
    
    // MARK: OVERRIDES
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        
        NSLayoutConstraint.activate([
            plusButton.heightAnchor.constraint(equalToConstant: 140),
            plusButton.widthAnchor.constraint(equalToConstant: 140),
            plusButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            plusButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40)
        ])
    }
    
    private func setupInputFields() {
        
        let stackView = UIStackView()
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signUpButton)
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

















