//
//  HomePostCell.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 17/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "homePostCell"
	
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
		iv.backgroundColor = UIColor.lightGray
		return iv
	}()
	
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.text = "Username"
		label.font = UIFont.boldSystemFont(ofSize: 14)
		return label
	}()
	
	let optionsButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("•••", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	
	let postImageView: CustomImageView = {
		let iv = CustomImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	let likeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "like_unselected").renderOriginal(), for: .normal)
		return button
	}()

	let commentButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "comment").renderOriginal(), for: .normal)
		return button
	}()
	
	let shareButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "send2").renderOriginal(), for: .normal)
		return button
	}()
	
	let bookmarkButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "ribbon").renderOriginal(), for: .normal)
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
	@objc private func optionsButtonClicked() {
		print("OPTIONS BUTTON CLICKED!")
	}
	
	
	
	// MARK: - Functions
	private func setupAttributedCaption() {
		guard let post = self.post else { return }
		
		let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [
			NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
			])
		
		attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)
			]))
		
		attributedText.append(NSAttributedString(string: "\n\n", attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)
			]))
		
		attributedText.append(NSAttributedString(string: "1 week ago", attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
			NSAttributedStringKey.foregroundColor: UIColor.gray
			]))
		
		captionLabel.attributedText = attributedText
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		self.addSubview(profileImageView)
		self.addSubview(usernameLabel)
		self.addSubview(optionsButton)
		self.addSubview(postImageView)
		self.addSubview(captionLabel)
		
		setupUserImageView()
		setupUsernameLabel()
		setupOptionsButton()
		setupPostImageView()
		setupActionButtons()
		setupCaptionLabel()
	}
	
	private func setupUserImageView() {
		profileImageView.anchor(top: self.topAnchor, equalTo: 8)
		profileImageView.anchor(left: self.leftAnchor, equalTo: 8)
		profileImageView.anchor(width: 40)
		profileImageView.anchor(height: 40)
		profileImageView.layer.cornerRadius = 20
	}
	
	private func setupUsernameLabel() {
		usernameLabel.anchor(top: self.topAnchor, equalTo: 0)
		usernameLabel.anchor(bottom: postImageView.topAnchor, equalTo: 0)
		usernameLabel.anchor(left: profileImageView.rightAnchor, equalTo: 8)
		usernameLabel.anchor(right: optionsButton.leftAnchor, equalTo: 8)
	}
	
	private func setupOptionsButton() {
		optionsButton.anchor(top: usernameLabel.topAnchor, equalTo: 0)
		optionsButton.anchor(bottom: usernameLabel.bottomAnchor, equalTo: 0)
		optionsButton.anchor(right: self.rightAnchor, equalTo: 0)
		optionsButton.anchor(width: 44)
		
		optionsButton.addTarget(self, action: #selector(optionsButtonClicked), for: .touchUpInside)
	}
	
	private func setupPostImageView() {
		postImageView.anchor(top: profileImageView.bottomAnchor, equalTo: 8)
		postImageView.anchor(left: self.leftAnchor, equalTo: 0)
		postImageView.anchor(right: self.rightAnchor, equalTo: 0)
		postImageView.anchor(height: self.bounds.width)
	}
	
	private func setupActionButtons() {
		let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
		stackView.distribution = .fillEqually
		
		self.addSubview(stackView)
		stackView.anchor(top: postImageView.bottomAnchor, equalTo: 0)
		stackView.anchor(left: self.leftAnchor, equalTo: 8)
		stackView.anchor(width: 120)
		stackView.anchor(height: 50)
		
		self.addSubview(bookmarkButton)
		bookmarkButton.anchor(top: postImageView.bottomAnchor, equalTo: 0)
		bookmarkButton.anchor(right: self.rightAnchor, equalTo: 8)
		bookmarkButton.anchor(width: 40)
		bookmarkButton.anchor(height: 50)
	}
	
	private func setupCaptionLabel() {
		captionLabel.anchor(top: likeButton.bottomAnchor, equalTo: 0)
		captionLabel.anchor(bottom: self.bottomAnchor, equalTo: 0)
		captionLabel.anchor(left: self.leftAnchor, equalTo: 8)
		captionLabel.anchor(right: self.rightAnchor, equalTo: 8)
	}
}

