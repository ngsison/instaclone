//
//  SharePhotoController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 29/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {

	
	
	// MARK: - Properties
	var selectedImage: UIImage? {
		didSet {
			if let image = selectedImage {
				imageView.image = image
			}
		}
	}
	
	let inputContainer: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white
		return view
	}()
	
	let imageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	
	
	// MARK: - Events
	@objc private func onShareBarButtonPress() {
		print("Share button was pressed!")
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		self.view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
		setupNavigationButtons()
		setupInputContainer()
		setupImageView()
	}
	
	private func setupNavigationButtons() {
		let shareBarButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(onShareBarButtonPress))
		self.navigationItem.rightBarButtonItem = shareBarButton
	}
	
	private func setupInputContainer() {
		self.view.addSubview(inputContainer)
		inputContainer.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, equalTo: 0)
		inputContainer.anchor(left: self.view.leftAnchor, equalTo: 0)
		inputContainer.anchor(right: self.view.rightAnchor, equalTo: 0)
		inputContainer.anchor(height: 100)
	}
	
	private func setupImageView() {
		inputContainer.addSubview(imageView)
		imageView.anchor(top: inputContainer.topAnchor, equalTo: 8)
		imageView.anchor(bottom: inputContainer.bottomAnchor, equalTo: 8)
		imageView.anchor(left: inputContainer.leftAnchor, equalTo: 8)
		imageView.anchor(width: 84)
	}
}




