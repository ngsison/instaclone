//
//  PhotoSelectorController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 26/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class PhotoSelectorController: UICollectionViewController {
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	
	
	// MARK: - Events
	@objc private func onCancelBarButtonPress() {
		print("Cancel button was pressed!")
		self.dismiss(animated: true, completion: nil)
	}
	
	@objc private func onNextBarButtonPress() {
		print("Next button was pressed")
		self.dismiss(animated: true, completion: nil)
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		collectionView?.backgroundColor = UIColor.yellow
		setupNavigationButtons()
	}
	
	private func setupNavigationButtons() {
		self.navigationController?.navigationBar.isTranslucent = false
		
		let cancelBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onCancelBarButtonPress))
		cancelBarButton.tintColor = UIColor.black
		self.navigationItem.leftBarButtonItem = cancelBarButton
		
		let nextBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.done, target: self, action: #selector(onNextBarButtonPress))
		self.navigationItem.rightBarButtonItem = nextBarButton
	}
}
