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
	var images = [UIImage]()
	var assets = [PHAsset]()
	var selectedImageIndex = 0
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: PhotoSelectorCell.identifier)
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
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoSelectorCell.identifier, for: indexPath) as! PhotoSelectorCell
		cell.imageView.image = self.images[indexPath.item]
		cell.selectedIndicatorView.isHidden = indexPath.item != self.selectedImageIndex
		
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PhotoSelectorHeader.identifier, for: indexPath) as! PhotoSelectorHeader
		
		if selectedImageIndex < self.images.count {
			fetchImage(for: self.assets[selectedImageIndex], targetSize: PHImageManagerMaximumSize) { (image, info) in
				header.imageView.image = image
			}
		}
		
		return header
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.selectedImageIndex = indexPath.item
		collectionView.reloadData()
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
		DispatchQueue.main.async {
			let creationDateSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
			
			let fetchOptions = PHFetchOptions()
			fetchOptions.fetchLimit = 50
			fetchOptions.sortDescriptors = [creationDateSortDescriptor]
			
			let photos = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
			
			photos.enumerateObjects { (asset: PHAsset, index: Int, pointer) in
				self.assets.append(asset)
				
				let targetImageSize = CGSize(width: 150, height: 150)
				self.fetchImage(for: asset, targetSize: targetImageSize) { (image, info) in
					if let image = image {
						self.images.append(image)
					}
					
					if index == photos.count - 1 {
						self.collectionView?.reloadData()
					}
				}
			}
		}
	}
	
	private func fetchImage(for asset: PHAsset, targetSize: CGSize, onSuccess: @escaping (_ image: UIImage?, _ info: [AnyHashable: Any]?) -> Void) {
		let imageManager = PHImageManager.default()
		let imageRequestOptions = PHImageRequestOptions()
		imageRequestOptions.isSynchronous = true
		
		imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: imageRequestOptions) { (image, info) in
			onSuccess(image, info)
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











