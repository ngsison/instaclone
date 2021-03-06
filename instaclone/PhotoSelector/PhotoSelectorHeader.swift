//
//  PhotoSelectorHeader.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 26/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "photoSelectorHeaderCell"
	
	let imageView: UIImageView = {
		let imageView = UIImageView()
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
		backgroundColor = UIColor.lightGray
		setupImageView()
		setupBottomBorder()
	}
	
	private func setupImageView() {
		addSubview(imageView)
		imageView.anchor(left: leftAnchor, equalTo: 0)
		imageView.anchor(right: rightAnchor, equalTo: 0)
		imageView.anchor(top: topAnchor, equalTo: 0)
		imageView.anchor(bottom: bottomAnchor, equalTo: 0)
	}
	
	private func setupBottomBorder() {
		let bottomBorder = UIView()
		bottomBorder.backgroundColor = UIColor.white
		
		addSubview(bottomBorder)
		bottomBorder.anchor(left: imageView.leftAnchor, equalTo: 0)
		bottomBorder.anchor(right: imageView.rightAnchor, equalTo: 0)
		bottomBorder.anchor(top: imageView.bottomAnchor, equalTo: 0)
		bottomBorder.anchor(height: 1)
	}
}
