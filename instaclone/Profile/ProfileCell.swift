//
//  ProfileCell.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 29/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "profileCell"
	var post: Post? {
		didSet {
			if let imageURL = post?.imageURL {
				guard let url = URL(string: imageURL) else { return }
				imageView.loadImage(from: url.absoluteString)
			}
		}
	}
	
	let imageView: CustomImageView = {
		let imageView = CustomImageView()
		imageView.contentMode = UIViewContentMode.scaleAspectFill
		imageView.clipsToBounds = true
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
		setupImageView()
	}
	
	private func setupImageView() {
		addSubview(imageView)
		imageView.anchor(left: leftAnchor, equalTo: 0)
		imageView.anchor(right: rightAnchor, equalTo: 0)
		imageView.anchor(top: topAnchor, equalTo: 0)
		imageView.anchor(bottom: bottomAnchor, equalTo: 0)
	}
	
}








