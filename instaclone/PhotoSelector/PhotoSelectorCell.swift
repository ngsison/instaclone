//
//  PhotoSelectorCell.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 26/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "photoSelectorCell"
	let imageView: UIImageView = {
		let imageView = UIImageView()
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
	func setImage(_ image: UIImage) {
		self.imageView.image = image
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		self.addSubview(imageView)
		imageView.anchor(left: self.leftAnchor, equalTo: 0)
		imageView.anchor(right: self.rightAnchor, equalTo: 0)
		imageView.anchor(top: self.topAnchor, equalTo: 0)
		imageView.anchor(bottom: self.bottomAnchor, equalTo: 0)
	}
}








