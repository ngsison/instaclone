//
//  PhotoPreviewContainer.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 27/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import Photos

class PhotoPreviewContainer: UIView {
	
	
	
	// MARK: - Properties
	let photoImageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	let cancelButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(#imageLiteral(resourceName: "cancel_shadow"), for: .normal)
		button.addTarget(self, action: #selector(onCancelButtonPress), for: .touchUpInside)
		return button
	}()
	
	let saveButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(#imageLiteral(resourceName: "save_shadow"), for: .normal)
		button.addTarget(self, action: #selector(onSaveButtonPress), for: .touchUpInside)
		return button
	}()
	
	
	
	// MARK: - Overrides
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	// MARK: - Events
	@objc private func onCancelButtonPress() {
		removeFromSuperview()
	}
	
	@objc private func onSaveButtonPress() {
		guard let previewImage = photoImageView.image else { return }
		
		let library = PHPhotoLibrary.shared()
		library.performChanges({
			PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
		}) { (success, error) in
			if let error = error {
				print("Failed to save image to photo library:", error)
			}
			
			if success {
				print("Successfully saved image to library.")
				
				DispatchQueue.main.async {
					let savedLabel = UILabel()
					savedLabel.text = "Saved Successfully"
					savedLabel.textColor = .white
					savedLabel.textAlignment = .center
					savedLabel.numberOfLines = 0
					savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
					savedLabel.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
					savedLabel.layer.cornerRadius = 10
					savedLabel.clipsToBounds = true
					
					savedLabel.frame = CGRect(x: 0, y: 0, width: 160, height: 80)
					savedLabel.center = self.center
					self.addSubview(savedLabel)
					
					savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
					
					UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
						savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
					}, completion: { (completed) in
						UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
							savedLabel.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
							savedLabel.alpha = 0
						}, completion: { (_) in
							savedLabel.removeFromSuperview()
							self.removeFromSuperview()
						})
					})
				}
			}
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupPhotoImageView()
		setupCancelButton()
		setupSaveButton()
	}
	
	private func setupPhotoImageView() {
		addSubview(photoImageView)
		photoImageView.anchor(top: topAnchor, equalTo: 0)
		photoImageView.anchor(bottom: bottomAnchor, equalTo: 0)
		photoImageView.anchor(left: leftAnchor, equalTo: 0)
		photoImageView.anchor(right: rightAnchor, equalTo: 0)
	}
	
	private func setupCancelButton() {
		addSubview(cancelButton)
		cancelButton.anchor(top: safeAreaLayoutGuide.topAnchor, equalTo: 12)
		cancelButton.anchor(left: leftAnchor, equalTo: 20)
		cancelButton.anchor(width: 50)
		cancelButton.anchor(height: 50)
	}
	
	private func setupSaveButton() {
		addSubview(saveButton)
		saveButton.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, equalTo: 12)
		saveButton.anchor(left: leftAnchor, equalTo: 20)
		saveButton.anchor(width: 50)
		saveButton.anchor(height: 50)
	}
}
