//
//  SharePhotoController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 29/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SharePhotoController: UIViewController {

	
	
	// MARK: - Properties
	var selectedImage: UIImage? {
		didSet {
			if let image = selectedImage {
				imageView.image = image
			}
		}
	}
	
	let inputContainer: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white
		return view
	}()
	
	let imageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	let captionTextView: UITextView = {
		let tv = UITextView()
		tv.font = UIFont.systemFont(ofSize: 14)
		return tv
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	
	
	// MARK: - Events
	@objc private func onShareBarButtonPress() {
		guard
			let image = selectedImage,
			let imageData = UIImageJPEGRepresentation(image, 0.5)
		else { return }
		
		navigationItem.rightBarButtonItem?.isEnabled = false
		
		let fileName = NSUUID().uuidString
		let reference = Storage.storage().reference().child("posts").child(fileName)
		reference.putData(imageData, metadata: nil) {
			(storageMetaData: StorageMetadata?, error: Error?) in
			
			if let error = error {
				self.navigationItem.rightBarButtonItem?.isEnabled = true
				print("Failed to upload photo: \(error)")
				return
			}
			
			// Get User's Profile Image's DownloadURL
			reference.downloadURL { (url, error) in
				if let error = error {
					self.navigationItem.rightBarButtonItem?.isEnabled = true
					print("Failed to retrieve image downloadURL: \(error)")
					return
				}
				
				guard let imageURL = url?.absoluteString else { return }
				self.savePostToDatabase(imageURL)
			}
		}
			
	}
	
	
	
	// MARK: - Functions
	private func savePostToDatabase(_ imageURL: String) {
		guard
			let uid = Auth.auth().currentUser?.uid,
			let postImage = selectedImage
		else { return }
		
		let postsRef = Database.database().reference().child("posts").child(uid)
		let postRef = postsRef.childByAutoId()
		let postDic: [String: Any] = [
			"imageURL": imageURL,
			"caption": captionTextView.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "",
			"imageWidth": postImage.size.width,
			"imageHeight": postImage.size.height,
			"createdOn": Date().timeIntervalSince1970
		]
		
		postRef.updateChildValues(postDic) { (error: Error?, dbRef: DatabaseReference) in
			if let error = error {
				self.navigationItem.rightBarButtonItem?.isEnabled = true
				print("Failed to save post to the database: \(error)")
				return
			}
			
			print("Successfully saved post to the database.")
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		self.view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
		setupNavigationButtons()
		setupInputContainer()
		setupImageView()
		setupTextView()
	}
	
	private func setupNavigationButtons() {
		let shareBarButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(onShareBarButtonPress))
		self.navigationItem.rightBarButtonItem = shareBarButton
	}
	
	private func setupInputContainer() {
		self.view.addSubview(inputContainer)
		inputContainer.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, equalTo: 0)
		inputContainer.anchor(left: self.view.leftAnchor, equalTo: 0)
		inputContainer.anchor(right: self.view.rightAnchor, equalTo: 0)
		inputContainer.anchor(height: 100)
	}
	
	private func setupImageView() {
		inputContainer.addSubview(imageView)
		imageView.anchor(top: inputContainer.topAnchor, equalTo: 8)
		imageView.anchor(bottom: inputContainer.bottomAnchor, equalTo: 8)
		imageView.anchor(left: inputContainer.leftAnchor, equalTo: 8)
		imageView.anchor(width: 84)
	}
	
	private func setupTextView() {
		inputContainer.addSubview(captionTextView)
		captionTextView.anchor(top: inputContainer.topAnchor, equalTo: 8)
		captionTextView.anchor(bottom: inputContainer.bottomAnchor, equalTo: 8)
		captionTextView.anchor(left: imageView.rightAnchor, equalTo: 8)
		captionTextView.anchor(right: inputContainer.rightAnchor, equalTo: 8)
	}
}




