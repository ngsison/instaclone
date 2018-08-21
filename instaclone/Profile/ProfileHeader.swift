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
	
	private let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 40
		imageView.layer.masksToBounds = true
		return imageView
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
		self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		setupProfileImage()
	}
	
	private func setupProfileImage() {
		self.addSubview(profileImageView)
		profileImageView.anchor(top: self.topAnchor, equalTo: 10)
		profileImageView.anchor(left: self.leftAnchor, equalTo: 10)
		profileImageView.anchor(width: 80)
		profileImageView.anchor(height: 80)
	}
}









