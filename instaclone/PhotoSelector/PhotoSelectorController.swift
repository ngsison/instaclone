//
//  PhotoSelectorController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 26/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	static let identifier = "photoSelectorCell"
	var images = [UIImage]()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PhotoSelectorController.identifier)
		self.collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PhotoSelectorHeader.identifier)
		
		setupViews()
		fetchPhotos()
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.images.count
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
	
	
	
	// MARK: - Functions
	private func fetchPhotos() {
		let fetchOptions = PHFetchOptions()
		fetchOptions.fetchLimit = 10
	
		let photos = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
		
		photos.enumerateObjects { (asset: PHAsset, index: Int, pointer) in
			let imageManager = PHImageManager.default()
			let targetImageSize = CGSize(width: 350, height: 350)
			let imageRequestOptions = PHImageRequestOptions()
			imageRequestOptions.isSynchronous = true
			
			imageManager.requestImage(for: asset, targetSize: targetImageSize, contentMode: .aspectFit, options: imageRequestOptions, resultHandler: {
				(image: UIImage?, info: [AnyHashable: Any]?) in
				
				if let image = image {
					self.images.append(image)
				}
				
				if index == photos.count - 1 {
					self.collectionView?.reloadData()
				}
			})
		}
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











