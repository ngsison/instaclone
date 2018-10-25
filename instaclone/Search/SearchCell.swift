//
//  SearchCell.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 25/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "searchCell"
	
	var user: User? {
		didSet {
			usernameLabel.text = user?.username
			
			if let imageURL = user?.profileImageURL {
				profileImageView.loadImage(from: imageURL)
			}
		}
	}
	
	let profileImageView: CustomImageView = {
		let iv = CustomImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		iv.backgroundColor = .lightGray
		return iv
	}()
	
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 14)
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
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupProfileImageView()
		setupUsernameLabel()
		setupSeparatorView()
	}
	
	private func setupProfileImageView() {
		self.addSubview(profileImageView)
		profileImageView.anchor(centerY: self.centerYAnchor)
		profileImageView.anchor(left: self.leftAnchor, equalTo: 8)
		profileImageView.anchor(width: 44)
		profileImageView.anchor(height: 44)
		
		profileImageView.layer.cornerRadius = 22
	}
	
	private func setupUsernameLabel() {
		self.addSubview(usernameLabel)
		usernameLabel.anchor(top: self.topAnchor, equalTo: 0)
		usernameLabel.anchor(bottom: self.bottomAnchor, equalTo: 0)
		usernameLabel.anchor(left: profileImageView.rightAnchor, equalTo: 8)
		usernameLabel.anchor(right: self.rightAnchor, equalTo: 8)
	}
	
	private func setupSeparatorView() {
		let separatorView = UIView()
		separatorView.backgroundColor = UIColor(white: 0, alpha: 0.25)
		
		self.addSubview(separatorView)
		separatorView.anchor(left: usernameLabel.leftAnchor, equalTo: 0)
		separatorView.anchor(right: rightAnchor, equalTo: 0)
		separatorView.anchor(bottom: bottomAnchor, equalTo: 0)
		separatorView.anchor(height: 0.5)
	}
}
