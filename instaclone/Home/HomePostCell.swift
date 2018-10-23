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
	
	public static let identifier = "homePostCell"
	
	var post: Post? {
		didSet {
			guard let imageURL = post?.imageURL else { return }
			photoImageView.loadImage(from: imageURL)
		}
	}
	
	let userImageView: CustomImageView = {
		let iv = CustomImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		iv.backgroundColor = UIColor.blue
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
	
	let photoImageView: CustomImageView = {
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
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		self.backgroundColor = UIColor.lightGray
		
		self.addSubview(userImageView)
		self.addSubview(usernameLabel)
		self.addSubview(optionsButton)
		self.addSubview(photoImageView)
		
		setupUserImageView()
		setupUsernameLabel()
		setupOptionsButton()
		setupPhotoImageView()
		setupActionButtons()
	}
	
	private func setupUserImageView() {
		userImageView.anchor(top: self.topAnchor, equalTo: 8)
		userImageView.anchor(left: self.leftAnchor, equalTo: 8)
		userImageView.anchor(width: 40)
		userImageView.anchor(height: 40)
		userImageView.layer.cornerRadius = 20
	}
	
	private func setupUsernameLabel() {
		usernameLabel.anchor(top: self.topAnchor, equalTo: 0)
		usernameLabel.anchor(bottom: photoImageView.topAnchor, equalTo: 0)
		usernameLabel.anchor(left: userImageView.rightAnchor, equalTo: 8)
		usernameLabel.anchor(right: optionsButton.leftAnchor, equalTo: 8)
	}
	
	private func setupOptionsButton() {
		optionsButton.anchor(top: usernameLabel.topAnchor, equalTo: 0)
		optionsButton.anchor(bottom: usernameLabel.bottomAnchor, equalTo: 0)
		optionsButton.anchor(right: self.rightAnchor, equalTo: 0)
		optionsButton.anchor(width: 44)
		
		optionsButton.addTarget(self, action: #selector(optionsButtonClicked), for: .touchUpInside)
	}
	
	private func setupPhotoImageView() {
		photoImageView.anchor(top: userImageView.bottomAnchor, equalTo: 8)
		photoImageView.anchor(left: self.leftAnchor, equalTo: 0)
		photoImageView.anchor(right: self.rightAnchor, equalTo: 0)
		photoImageView.anchor(height: self.bounds.width)
	}
	
	private func setupActionButtons() {
		let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
		stackView.distribution = .fillEqually
		
		self.addSubview(stackView)
		stackView.anchor(top: photoImageView.bottomAnchor, equalTo: 0)
		stackView.anchor(left: self.leftAnchor, equalTo: 8)
		stackView.anchor(width: 120)
		stackView.anchor(height: 50)
		
		self.addSubview(bookmarkButton)
		bookmarkButton.anchor(top: photoImageView.bottomAnchor, equalTo: 0)
		bookmarkButton.anchor(right: self.rightAnchor, equalTo: 8)
		bookmarkButton.anchor(width: 40)
		bookmarkButton.anchor(height: 50)
	}
}

