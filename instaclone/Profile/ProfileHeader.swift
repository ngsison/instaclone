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
		guard let profileImageURL = user.profileImageURL else { return }
		
		profileImageView.loadImage(from: profileImageURL) {
			self.profileImageView.layer.borderColor = UIColor.black.cgColor
			self.profileImageView.layer.borderWidth = 2
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupProfileImage()
		setupToolbar()
	}
	
	private func setupProfileImage() {
		self.addSubview(profileImageView)
		profileImageView.anchor(top: self.topAnchor, equalTo: 10)
		profileImageView.anchor(left: self.leftAnchor, equalTo: 10)
		profileImageView.anchor(width: 80)
		profileImageView.anchor(height: 80)
	}
	
	private func setupToolbar() {
		let stackView = UIStackView()
		stackView.distribution = .fillEqually
		stackView.addArrangedSubview(gridButton)
		stackView.addArrangedSubview(listButton)
		stackView.addArrangedSubview(bookmarkButton)
		
		self.addSubview(stackView)
		stackView.anchor(left: self.leftAnchor, equalTo: 0)
		stackView.anchor(right: self.rightAnchor, equalTo: 0)
		stackView.anchor(bottom: self.bottomAnchor, equalTo: 0)
		stackView.anchor(height: 50)
	}
}









