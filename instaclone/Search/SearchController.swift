//
//  SearchController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 25/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController {
	
	
	
	// MARK: - Properties
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
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
		return cell
	}
	
	
	
	// MARK: - Functions
	private func configureCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.alwaysBounceVertical = true
		collectionView?.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
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
