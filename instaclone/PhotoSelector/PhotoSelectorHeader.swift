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
	
	
	
	// MARK: - Overrides
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	// MARK: - SetupViews
	private func setupViews() {
		self.backgroundColor = UIColor.red
	}
}
