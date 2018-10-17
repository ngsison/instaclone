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
	
	let photoImageView: CustomImageView = {
		let iv = CustomImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		
		return iv
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
		setupPhotoImageView()
	}
	
	private func setupPhotoImageView() {
		self.addSubview(photoImageView)
		photoImageView.anchor(top: self.topAnchor, equalTo: 0)
		photoImageView.anchor(bottom: self.bottomAnchor, equalTo: 0)
		photoImageView.anchor(left: self.leftAnchor, equalTo: 0)
		photoImageView.anchor(right: self.rightAnchor, equalTo: 0)
	}
}

