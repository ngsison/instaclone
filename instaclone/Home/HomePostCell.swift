//
//  HomePostCell.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 17/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

protocol HomePostCellDelegate {
	func didTapComment(post: Post)
}

class HomePostCell: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "homePostCell"
	
	var delegate: HomePostCellDelegate?
	
	var post: Post? {
		didSet {
			usernameLabel.text = post?.user.username;
			setupAttributedCaption()
			
			if let profileImageURL = post?.user.profileImageURL {
				profileImageView.loadImage(from: profileImageURL)
			}
			
			if let postImageURL = post?.imageURL {
				postImageView.loadImage(from: postImageURL)
			}
		}
	}
	
	let profileImageView: CustomImageView = {
		let iv = CustomImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		iv.backgroundColor = .lightGray
		iv.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
		iv.layer.borderWidth = 0.5
		return iv
	}()
	
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.text = "Username"
		label.font = UIFont.boldSystemFont(ofSize: 14)
		return label
	}()
	
	lazy var optionsButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("•••", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.addTarget(self, action: #selector(onOptionsButtonPress), for: .touchUpInside)
		return button
	}()
	
	let postImageView: CustomImageView = {
		let iv = CustomImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	let likeButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
		return button
	}()

	lazy var commentButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
		button.addTarget(self, action: #selector(onCommentButtonPress), for: .touchUpInside)
		return button
	}()
	
	let shareButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
		return button
	}()
	
	let bookmarkButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
		return button
	}()
	
	let captionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		return label
	}()
	
	
	// MARK: - Overrides
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	// MARK: - Events
	@objc private func onCommentButtonPress() {
		guard let post = post else { return }
		delegate?.didTapComment(post: post)
	}
	
	@objc private func onOptionsButtonPress() {
		print("OPTIONS BUTTON PRESSED!")
	}
	
	
	
	// MARK: - Functions
	private func setupAttributedCaption() {
		guard let post = post else { return }
		
		let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [
			NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
			])
		
		attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)
			])) 
		
		attributedText.append(NSAttributedString(string: "\n\n", attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)
			]))
		
		attributedText.append(NSAttributedString(string: post.createdOn.timeAgoDisplay(), attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
			NSAttributedStringKey.foregroundColor: UIColor.gray
			]))
		
		captionLabel.attributedText = attributedText
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		addSubview(profileImageView)
		addSubview(usernameLabel)
		addSubview(optionsButton)
		addSubview(postImageView)
		addSubview(captionLabel)
		
		setupUserImageView()
		setupUsernameLabel()
		setupOptionsButton()
		setupPostImageView()
		setupActionButtons()
		setupCaptionLabel()
	}
	
	private func setupUserImageView() {
		profileImageView.anchor(top: topAnchor, equalTo: 8)
		profileImageView.anchor(left: leftAnchor, equalTo: 8)
		profileImageView.anchor(width: 40)
		profileImageView.anchor(height: 40)
		profileImageView.layer.cornerRadius = 20
	}
	
	private func setupUsernameLabel() {
		usernameLabel.anchor(top: topAnchor, equalTo: 0)
		usernameLabel.anchor(bottom: postImageView.topAnchor, equalTo: 0)
		usernameLabel.anchor(left: profileImageView.rightAnchor, equalTo: 8)
		usernameLabel.anchor(right: optionsButton.leftAnchor, equalTo: 8)
	}
	
	private func setupOptionsButton() {
		optionsButton.anchor(top: usernameLabel.topAnchor, equalTo: 0)
		optionsButton.anchor(bottom: usernameLabel.bottomAnchor, equalTo: 0)
		optionsButton.anchor(right: rightAnchor, equalTo: 0)
		optionsButton.anchor(width: 44)
	}
	
	private func setupPostImageView() {
		postImageView.anchor(top: profileImageView.bottomAnchor, equalTo: 8)
		postImageView.anchor(left: leftAnchor, equalTo: 0)
		postImageView.anchor(right: rightAnchor, equalTo: 0)
		postImageView.anchor(height: bounds.width)
	}
	
	private func setupActionButtons() {
		let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
		stackView.distribution = .fillEqually
		
		addSubview(stackView)
		stackView.anchor(top: postImageView.bottomAnchor, equalTo: 0)
		stackView.anchor(left: leftAnchor, equalTo: 8)
		stackView.anchor(width: 120)
		stackView.anchor(height: 50)
		
		addSubview(bookmarkButton)
		bookmarkButton.anchor(top: postImageView.bottomAnchor, equalTo: 0)
		bookmarkButton.anchor(right: rightAnchor, equalTo: 8)
		bookmarkButton.anchor(width: 40)
		bookmarkButton.anchor(height: 50)
	}
	
	private func setupCaptionLabel() {
		captionLabel.anchor(top: likeButton.bottomAnchor, equalTo: 0)
		captionLabel.anchor(bottom: bottomAnchor, equalTo: 0)
		captionLabel.anchor(left: leftAnchor, equalTo: 8)
		captionLabel.anchor(right: rightAnchor, equalTo: 8)
	}
}

