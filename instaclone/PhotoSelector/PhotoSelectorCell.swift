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
		imageView.contentMode = UIViewContentMode.scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()
	
	let selectedIndicatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 0.6)
		view.isHidden = true
		return view
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
		setupSelectedIndicator()
	}
	
	private func setupImageView() {
		addSubview(imageView)
		imageView.anchor(left: leftAnchor, equalTo: 0)
		imageView.anchor(right: rightAnchor, equalTo: 0)
		imageView.anchor(top: topAnchor, equalTo: 0)
		imageView.anchor(bottom: bottomAnchor, equalTo: 0)
	}
	
	private func setupSelectedIndicator() {
		addSubview(selectedIndicatorView)
		selectedIndicatorView.anchor(left: leftAnchor, equalTo: 0)
		selectedIndicatorView.anchor(right: rightAnchor, equalTo: 0)
		selectedIndicatorView.anchor(top: topAnchor, equalTo: 0)
		selectedIndicatorView.anchor(bottom: bottomAnchor, equalTo: 0)
	}
	
}








