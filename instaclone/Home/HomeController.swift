//
//  HomeController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 17/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	var posts = [Post]()
	
	// Because clearing posts immediately before `refresh` is causing the app to crash,
	// we need this to temporarily hold the posts being fetched from Firebase
	// and assign it as the value of `posts` just after successful fetch.
	// PM the developer for more info. LOL
	var tempPosts = [Post]()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		setupViews()
		fetchFollowedUsersPosts()
	}

	
	
	// MARK: - UICollectionView
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return posts.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePostCell.identifier, for: indexPath) as! HomePostCell
		cell.post = posts[indexPath.item]
		cell.delegate = self
		
		return cell
	}
	
	
	
	// MARK: - Events
	@objc private func onCameraButtonPress() {
		let cameraController = CameraController()
		present(cameraController, animated: true, completion: nil)
	}
	
	@objc private func onRefresh() {
		collectionView?.refreshControl?.beginRefreshing()
		fetchFollowedUsersPosts()
	}
	
	
	
	// MARK: - Functions
	private func configureCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: HomePostCell.identifier)
		
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
		collectionView?.refreshControl = refreshControl
	}
	
	private func fetchFollowedUsersPosts() {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		tempPosts.removeAll()
		Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value) { (snapshot) in
			guard let snapshotDict = snapshot.value as? [String: Any] else { return }
			
			for (key, value) in snapshotDict {
				if let isFollowing = value as? Int, isFollowing == 1 {
					Database.fetchUser(withUID: key) { (user) in
						self.fetchPosts(from: user)
					}
				}
			}
		}
	}
	
	private func fetchPosts(from user: User) {
		Database.database().reference().child("posts").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
			self.collectionView?.refreshControl?.endRefreshing()
			
			guard let snapshotDict = snapshot.value as? [String: Any] else {
				print("No posts were fecthed.")
				return
			}
			
			for (key, value) in snapshotDict {
				guard let postDict = value as? [String: Any] else { return }
				let post = Post(user: user, dictionary: postDict)
				post.postID = key
				
				if let uid = Auth.auth().currentUser?.uid {
					Database.database().reference().child("likes").child(key).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
						if let value = snapshot.value as? Int {
							post.isLikedByMe = value == 1
						}
						
						self.tempPosts.append(post)
						self.tempPosts.sort(by: { (post1, post2) -> Bool in
							return post1.createdOn.compare(post2.createdOn) == .orderedDescending
						})
						self.posts = self.tempPosts
						self.collectionView?.reloadData()
					}, withCancel: { (error) in
						print("Failed to fetch likes for post \(key):", error)
					})
				}
			}
		}) { (error: Error) in
			print("Failed to retrieve posts from the database: \(error)")
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupNavigationItems()
	}
	
	private func setupNavigationItems() {
		navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3").renderOriginal(), style: .plain, target: self, action: #selector(onCameraButtonPress))
	}
}



// MARK: - Extension: UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var height: CGFloat = 8 + 40 + 8 	// user imageview
		height += view.frame.width			// post imageview
		height += 50						// action buttons
		height += 60						// caption
		
		return CGSize(width: view.frame.width, height: height)
	}
	
}



// MARK: - Extension: HomePostCellDelegate
extension HomeController: HomePostCellDelegate {
	func didLike(cell: HomePostCell) {
		guard
			let uid = Auth.auth().currentUser?.uid,
			let post = cell.post,
			let postID = post.postID,
			let indexPath = collectionView?.indexPath(for: cell)
		else { return }
		
		let value = post.isLikedByMe ? 0 : 1
		let values = [uid: value]

		post.isLikedByMe = !post.isLikedByMe
		collectionView?.reloadItems(at: [indexPath])
		
		Database.database().reference().child("likes").child(postID).updateChildValues(values) { (error, dbRef) in
			if let error = error {
				print("Failed to \(value == 1 ? "like" : "unlike") post:", error)
				post.isLikedByMe = !post.isLikedByMe
				self.collectionView?.reloadItems(at: [indexPath])
				return
			}
			
			print("Successfully \(value == 1 ? "liked" : "unliked") post")
		}
	}
	
	func didTapComment(post: Post) {
		let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
		commentsController.post = post
		navigationController?.pushViewController(commentsController, animated: true)
	}
}
