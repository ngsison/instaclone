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
		imageView.backgroundColor = .red
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
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		self.backgroundColor = .blue
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









