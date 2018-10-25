//
//  SearchController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 25/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	var users = [User]()
	
	let searchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.placeholder = "Enter username"
		
		UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
		
		return sb
	}()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		setupViews()
		fetchUsers()
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return users.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
		cell.user = users[indexPath.item]
		return cell
	}
	
	
	
	// MARK: - Functions
	private func configureCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.alwaysBounceVertical = true
		collectionView?.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
	}
	
	private func fetchUsers() {
		Database.database().reference().child("users").observeSingleEvent(of: .value) { (snapshot) in
			guard let snapshotDict = snapshot.value as? [String: Any] else { return }
			
			for (key, value) in snapshotDict {
				guard let userDict = value as? [String: Any] else { return }
				let user = User(uid: key, dictionary: userDict)
				self.users.append(user)
			}
			
			self.collectionView?.reloadData()
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupSearchBar()
	}
	
	private func setupSearchBar() {
		guard let navBar = self.navigationController?.navigationBar else { return }
		
		navBar.addSubview(searchBar)
		searchBar.anchor(top: navBar.topAnchor, equalTo: 0)
		searchBar.anchor(bottom: navBar.bottomAnchor, equalTo: 0)
		searchBar.anchor(left: navBar.leftAnchor, equalTo: 8)
		searchBar.anchor(right: navBar.rightAnchor, equalTo: 8)
	}
}



// MARK: - Extension: UICollectionViewDelegateFlowLayout
extension SearchController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 60)
	}
}
