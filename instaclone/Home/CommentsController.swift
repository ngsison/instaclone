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
		return containerView
	}()
	
	let submitButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Post", for: .normal)
		//button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.addTarget(self, action: #selector(onSubmitButtonPress), for: .touchUpInside)
		return button
	}()
	
	let commentTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Add a comment..."
		textField.autocorrectionType = .no
		textField.font = UIFont.systemFont(ofSize: 14)
		return textField
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		setupViews()
		fetchComments()
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
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return post?.comments.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
		cell.comment = post?.comments[indexPath.item]
		return cell
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
			
			self.commentTextField.text = ""
			print("Successfully inserted comment")
		}
		
	}
	
	
	
	// MARK: - Functions
	private func configureCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.alwaysBounceVertical = true
		collectionView?.keyboardDismissMode = .interactive
		collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		collectionView?.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
	}
	
	private func fetchComments() {
		guard let postID = post?.postID else { return }
		
		post?.comments.removeAll()
		Database.database().reference().child("comments").child(postID).observe(.childAdded, with: { (snapshot) in
			guard
				let snapshotDict = snapshot.value as? [String: Any],
				let userID = snapshotDict["userID"] as? String
			else { return }
			
			Database.fetchUser(withUID: userID, onSuccess: { (user) in
				let comment = Comment(user: user, dictionary: snapshotDict)
				self.post?.comments.append(comment)
				self.collectionView?.reloadData()
			})
		}) { (error) in
			print("Failed to fetch comments:", error)
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		title = "Comments"
		configureContainerView()
		setupSubmitButton()
		setupCommentTextField()
	}
	
	private func configureContainerView() {
		containerView.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
		
		let lineSeparatorView = UIView()
		lineSeparatorView.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
		
		containerView.addSubview(lineSeparatorView)
		lineSeparatorView.anchor(top: containerView.topAnchor, equalTo: 0)
		lineSeparatorView.anchor(left: containerView.leftAnchor, equalTo: 0)
		lineSeparatorView.anchor(right: containerView.rightAnchor, equalTo: 0)
		lineSeparatorView.anchor(height: 0.5)
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



// MARK: - Extension: UICollectionViewDelegateFlowLayout
extension CommentsController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
		
		let dummyCell = CommentCell(frame: frame)
		dummyCell.comment = post?.comments[indexPath.item]
		dummyCell.layoutIfNeeded()
		
		let targetSize = CGSize(width: view.frame.width, height: 1000)
		let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
		
		let height = max(40 + 8 + 8, estimatedSize.height)
		return CGSize(width: view.frame.width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}
