//
//  ProfileController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 21/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	private var username: String?
	private var profileImageURL: String?
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
	
		getUserData()
		setupViews()
		
		collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProfileHeader.identifier)
	}
	
	

	// MARK: - Functions
	private func getUserData() {
		let reference = Database.database().reference().child("users")
		
		guard let userID = Auth.auth().currentUser?.uid else { return }
		
		reference.child(userID).observeSingleEvent(of: DataEventType.value) { (snapshot: DataSnapshot) in
			
			guard let snapshotDict = snapshot.value as? [String: Any] else { return }
			
			self.username = snapshotDict["username"] as? String
			self.profileImageURL = snapshotDict["profileImageURL"] as? String
			
			self.loadDataToUI()
		}
	}
	
	private func loadDataToUI() {
		self.navigationItem.title = self.username
	}
	
	
	
	// MARK: - SetupViews
	private func setupViews() {
		self.collectionView?.backgroundColor = .white
	}
}



// MARK: - Extension: UICollectionView
extension ProfileController: UICollectionViewDelegateFlowLayout {
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.identifier, for: indexPath)
		header.backgroundColor = .blue
		
		return header
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: view.frame.width, height: 200)
	}
	
}















