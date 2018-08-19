//
//  ViewController.swift
//  instaclone
//
//  Created by Nathaniel SISON on 14/8/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController {
    
    
    
    // MARK: - Properties
    let plusButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").renderOriginal(), for: UIControlState.normal)
        button.addTarget(self, action: #selector(onPlusButtonPress), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(onTextInputChanged), for: UIControlEvents.editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = UITextBorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
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
        tf.addTarget(self, action: #selector(onTextInputChanged), for: UIControlEvents.editingChanged)
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
        button.isEnabled = false
        button.addTarget(self, action: #selector(onSignUpButtonPress), for: UIControlEvents.touchUpInside)
        
        return button
    }()
    
    
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }


    
    // MARK: - Events
    @objc func onSignUpButtonPress() {
        guard
            let email = emailTextField.text, email.count > 0,
            let username = usernameTextField.text, username.count > 0,
            let password = passwordTextField.text, password.count > 0
        else { return }

        
        
        // Sign Up User
        Auth.auth().createUser(withEmail: email, password: password) { (result: AuthDataResult?, error: Error?) in
            
            if let error = error {
                print("Failed to create user: \(error)")
                return
            }
            
            print("Successfully created user: \(result!.user.email!)")
            
            
            
            // Upload User's Profile Image
            guard
                let image = self.plusButton.imageView?.image,
                let imageData = UIImageJPEGRepresentation(image, 0.3)
            else { return }
            
            let fileName = NSUUID().uuidString
            let profileImagesRef = Storage.storage().reference().child("profile_images").child(fileName)
            
            profileImagesRef.putData(imageData, metadata: nil, completion: {
                (storageMetaData: StorageMetadata?, error: Error?) in
              
                if let error = error {
                    print("Failed to upload profile image: \(error)")
                    return
                }
                
                print("Successfully uploaded profile image")
                
                
                
                // Get User's Profile Image's DownloadURL
                profileImagesRef.downloadURL(completion: { (url, error) in
                    
                    guard let profileImageURL = url?.absoluteString else { return }
                    print("Successfully fetched profile image's DownloadURL: \(profileImageURL)")
                    
                    
                    
                    // Save User's Details to the Database
                    guard let uid = result?.user.uid else { return }
                    
                    let userDetails: [String: String] = [
                        "username": username,
                        "profileImageURL": profileImageURL
                    ]
                    
                    let user = [uid: userDetails]
                    Database.database().reference().child("users").updateChildValues(user, withCompletionBlock: {
                        (error: Error?, dbRef: DatabaseReference) in
                        
                        if let error = error {
                            print("Failed to save user info to database: \(error)")
                            return
                        }
                        
                        print("Successfully saved user info to database")
                    })
                })
            })
        }
    }
    
    @objc func onTextInputChanged() {
        let emailIsValid = emailTextField.text!.count > 0
        let usernameIsValid = usernameTextField.text!.count > 0
        let passwordIsValid = passwordTextField.text!.count > 0
        
        if emailIsValid && usernameIsValid && passwordIsValid {
            signUpButton.backgroundColor = UIColor.rgb(17, 154, 237)
            signUpButton.isEnabled = true
        }
        else {
            signUpButton.backgroundColor = UIColor.rgb(149, 204, 244)
            signUpButton.isEnabled = false
        }
    }
    
    @objc func onPlusButtonPress() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - SetupViews
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



// MARK - Extension: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
//        let imageURL = info["UIImagePickerControllerImageURL"]
//        let mediaType = info["UIImagePickerControllerMediaType"]
//        let referenceURL = info["UIImagePickerControllerReferenceURL"]
//        let cropRect = info["UIImagePickerControllerCropRect"]
        
        plusButton.layer.cornerRadius = plusButton.frame.width / 2
        plusButton.layer.masksToBounds = true
        
        plusButton.layer.borderColor = UIColor.black.cgColor
        plusButton.layer.borderWidth = 3
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusButton.setImage(editedImage.renderOriginal(), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            plusButton.setImage(originalImage.renderOriginal(), for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}










