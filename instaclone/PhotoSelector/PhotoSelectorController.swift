//
//  PhotoSelectorController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 26/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class PhotoSelectorController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	static let identifier = "photoSelectorCell"
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PhotoSelectorController.identifier)
		self.collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PhotoSelectorHeader.identifier)
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoSelectorController.identifier, for: indexPath)
		cell.backgroundColor = UIColor.blue
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PhotoSelectorHeader.identifier, for: indexPath) as! PhotoSelectorHeader
		return header
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
		self.collectionView?.backgroundColor = UIColor.white
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



// MARK: Extension: UICollectionViewDelegateFlowLayout
extension PhotoSelectorController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let availableWidth = (self.view.frame.width - 3) / 4
		return CGSize(width: availableWidth, height: availableWidth)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: self.view.frame.width, height: self.view.frame.width)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
	}
	
}










