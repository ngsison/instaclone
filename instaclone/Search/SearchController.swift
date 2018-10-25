//
//  SearchController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 25/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SearchController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	var users = [User]()
	var filteredUsers = [User]()
	
	lazy var searchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.placeholder = "Enter username"
		sb.delegate = self
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		searchBar.isHidden = false
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return filteredUsers.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
		cell.user = filteredUsers[indexPath.item]
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let user = filteredUsers[indexPath.item]
		
		searchBar.isHidden = true
		searchBar.resignFirstResponder()
		
		let profileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
		profileController.userID = user.uid
		
		self.navigationController?.pushViewController(profileController, animated: true)
	}
	
	
	
	// MARK: - Functions
	private func configureCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.alwaysBounceVertical = true
		collectionView?.keyboardDismissMode = .onDrag
		collectionView?.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
	}
	
	private func fetchUsers() {
		Database.database().reference().child("users").observeSingleEvent(of: .value) { (snapshot) in
			guard let snapshotDict = snapshot.value as? [String: Any] else { return }
			
			for (key, value) in snapshotDict {
				guard let userDict = value as? [String: Any] else { return }
				
				if key == Auth.auth().currentUser?.uid {
					continue
				}
				
				let user = User(uid: key, dictionary: userDict)
				self.users.append(user)
			}
			
			self.users.sort(by: { (user1, user2) -> Bool in
				return user1.username.compare(user2.username) == .orderedAscending
			})
			
			self.filteredUsers = self.users
			self.collectionView?.reloadData()
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupSearchBar()
	}
	
	private func setupSearchBar() {
		guard let navBar = navigationController?.navigationBar else { return }
		
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



// MARK: - Extension: UISearchBarDelegate
extension SearchController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			filteredUsers = users
		} else {
			filteredUsers = users.filter({ (user) -> Bool in
				return user.username.lowercased().contains(searchText.lowercased())
			})
		}
		collectionView?.reloadData()
	}
}
