//
//  CommentsController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 27/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CommentsController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	var post: Post?
	
	let containerView: UIView = {
		let containerView = UIView()
		containerView.backgroundColor = .white
		containerView.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
		return containerView
	}()
	
	let submitButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Submit", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.addTarget(self, action: #selector(onSubmitButtonPress), for: .touchUpInside)
		return button
	}()
	
	let commentTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Enter Comment"
		textField.autocorrectionType = .no
		return textField
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		tabBarController?.tabBar.isHidden = false
	}
	
	override var inputAccessoryView: UIView? {
		return containerView
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
	
	
	
	// MARK: - Events
	@objc private func onSubmitButtonPress() {
		guard
			let userID = Auth.auth().currentUser?.uid,
			let postID = post?.postID,
			let comment = commentTextField.text
		else { return }
		
		let values = [
			"userID": userID,
			"comment": comment,
			"creationDate": Date().timeIntervalSince1970
		] as [String: Any]
		
		Database.database().reference().child("comments").child(postID).childByAutoId().updateChildValues(values) { (error, dbRef) in
			if let error = error {
				print("Failed to insert comment:", error)
			}
			
			print("Successfully inserted comment")
		}
		
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		collectionView?.backgroundColor = .red
		title = "Comments"
		setupSubmitButton()
		setupCommentTextField()
	}
	
	private func setupSubmitButton() {
		containerView.addSubview(submitButton)
		submitButton.anchor(top: containerView.topAnchor, equalTo: 0)
		submitButton.anchor(bottom: containerView.bottomAnchor, equalTo: 0)
		submitButton.anchor(right: containerView.rightAnchor, equalTo: 12)
		submitButton.anchor(width: 60)
	}
	
	private func setupCommentTextField() {
		containerView.addSubview(commentTextField)
		commentTextField.anchor(top: containerView.topAnchor, equalTo: 0)
		commentTextField.anchor(bottom: containerView.bottomAnchor, equalTo: 0)
		commentTextField.anchor(left: containerView.leftAnchor, equalTo: 12)
		commentTextField.anchor(right: submitButton.leftAnchor, equalTo: 0)
	}
}
