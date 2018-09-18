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
				
				self.imageView.image = nil
				URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
					if let error = error {
						print(error)
						return
					}
					
					if (url.absoluteString != self.post?.imageURL) { return }
					
					guard let imageData = data else { return }
					DispatchQueue.main.async(execute: {
						self.imageView.image = UIImage(data: imageData)
					})
				}.resume()
			}
		}
	}
	
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
		setupImageView()
	}
	
	private func setupImageView() {
		self.addSubview(imageView)
		imageView.anchor(left: self.leftAnchor, equalTo: 0)
		imageView.anchor(right: self.rightAnchor, equalTo: 0)
		imageView.anchor(top: self.topAnchor, equalTo: 0)
		imageView.anchor(bottom: self.bottomAnchor, equalTo: 0)
	}
	
}








