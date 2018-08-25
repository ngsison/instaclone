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
    private var identifier = "profileCell"
	private var user: User?
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
	
		getUserData()
		setupViews()
		
		collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProfileHeader.identifier)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.identifier)
        collectionView?.collectionViewLayout = UICollectionViewFlowLayout()
	}
	
	

	// MARK: - Events
	@objc private func onLogoutButtonPress() {
		print("Logout button was pressed!")
	}
	
	
	
	// MARK: - Functions
	private func getUserData() {
		let reference = Database.database().reference().child("users")
		
		guard let userID = Auth.auth().currentUser?.uid else { return }
		
		reference.child(userID).observeSingleEvent(of: DataEventType.value) { (snapshot: DataSnapshot) in
			
			guard let snapshotDict = snapshot.value as? [String: Any] else { return }
			
			self.user = User(withDictionary: snapshotDict)
			
			self.loadDataToUI()
			self.collectionView?.reloadData()
		}
	}
	
	private func loadDataToUI() {
		self.navigationItem.title = self.user?.username
	}
	
	
	
	// MARK: - SetupViews
	private func setupViews() {
		self.collectionView?.backgroundColor = .white
		setupLogoutButton()
	}
	
	private func setupLogoutButton() {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").renderOriginal(), style: UIBarButtonItemStyle.plain, target: self, action: #selector(onLogoutButtonPress))
	}
}



// MARK: - Extension: UICollectionView
extension ProfileController: UICollectionViewDelegateFlowLayout {
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.identifier, for: indexPath) as! ProfileHeader
		
		if let user = self.user {
			header.loadProfileData(for: user)
		}
		
		return header
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		
		return CGSize(width: view.frame.width, height: 200)
	}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = (self.view.frame.width - 2) / 3
        return CGSize(width: availableWidth, height: availableWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}















