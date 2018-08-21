//
//  ProfileHeader.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 21/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "profileHeader"
	
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 40
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	public let gridButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.2)
		return button
	}()
	
	let listButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.2)
		return button
	}()
	
	let bookmarkButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.2)
		return button
	}()
	
	let toolbarStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 14)
		label.textColor = .black
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
	
	
	
	// MARK: - Functions
	func loadProfileData(for user: User) {
		guard
			let username = user.username,
			let profileImageURL = user.profileImageURL
		else { return }
		
		usernameLabel.text = username
		profileImageView.loadImage(from: profileImageURL) {
			self.profileImageView.layer.borderColor = UIColor.black.cgColor
			self.profileImageView.layer.borderWidth = 2
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupProfileImage()
		setupToolbar()
		setupUsername()
	}
	
	private func setupProfileImage() {
		self.addSubview(profileImageView)
		profileImageView.anchor(top: self.topAnchor, equalTo: 10)
		profileImageView.anchor(left: self.leftAnchor, equalTo: 10)
		profileImageView.anchor(width: 80)
		profileImageView.anchor(height: 80)
	}
	
	private func setupToolbar() {
		toolbarStackView.addArrangedSubview(gridButton)
		toolbarStackView.addArrangedSubview(listButton)
		toolbarStackView.addArrangedSubview(bookmarkButton)
		
		self.addSubview(toolbarStackView)
		toolbarStackView.anchor(left: self.leftAnchor, equalTo: 0)
		toolbarStackView.anchor(right: self.rightAnchor, equalTo: 0)
		toolbarStackView.anchor(bottom: self.bottomAnchor, equalTo: 0)
		toolbarStackView.anchor(height: 50)
	}
	
	private func setupUsername() {
		self.addSubview(usernameLabel)
		usernameLabel.anchor(left: self.leftAnchor, equalTo: 10)
		usernameLabel.anchor(right: self.rightAnchor, equalTo: -10)
		usernameLabel.anchor(top: profileImageView.bottomAnchor, equalTo: 0)
		usernameLabel.anchor(bottom: toolbarStackView.topAnchor, equalTo: 0)
	}
}









