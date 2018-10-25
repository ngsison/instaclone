//
//  ProfileHeader.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 21/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

enum action {
	case follow
	case unfollow
	case editProfile
}

class ProfileHeader: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "profileHeaderCell"
	var user: User? {
		didSet {
			usernameLabel.text = user?.username
			if let profileImageURL = user?.profileImageURL {
				profileImageView.loadImage(from: profileImageURL)
			}
			updateStats()
			setupEditFollowButton()
		}
	}
	
	let profileImageView: CustomImageView = {
		let iv = CustomImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		iv.backgroundColor = .lightGray
		iv.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
		iv.layer.borderWidth = 0.5
		return iv
	}()
	
	let gridButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
		return button
	}()
	
	let listButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.2)
		return button
	}()
	
	let bookmarkButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.2)
		return button
	}()
	
	let toolbarStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 14)
		label.textColor = .black
		return label
	}()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
		button.layer.borderColor = UIColor.lightGray.cgColor
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.addTarget(self, action: #selector(onEditProfileFollowButtonPress), for: .touchUpInside)
        return button
    }()
	
	
	
	// MARK: - Overrides
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	// MARK: - Events
	@objc private func onEditProfileFollowButtonPress() {
		guard
			let user = user,
			let currentUser = Auth.auth().currentUser
		else { return }
		
		var values = [user.uid: 0] // 0 = unfollow
		if editProfileFollowButton.titleLabel?.text == "Follow" {
			values = [user.uid: 1] // 1 = follow
		}
		
		Database.database().reference().child("following").child(currentUser.uid).updateChildValues(values) { (error, dbRef) in
			guard let user = self.user else { return }
			
			if let error = error {
				print("Failed to \(values[user.uid] == 0 ? "Unfollow" : "Follow"):", error)
				return
			}
			
			print("Successfully \(values[user.uid] == 0 ? "Unfollowed" : "Followed") user:", self.user?.username ?? "")
			self.setupEditFollowButton()
		}
	}
	
	
	
	// MARK: - Functions
	private func updateStats() {
		let posts = user?.posts.count ?? 0
		let followers = 0
		let following = 0
		
		postsLabel.attributedText = getAttributedTextForStat(count: posts, label: "posts")
		followersLabel.attributedText = getAttributedTextForStat(count: followers, label: "followers")
		followingLabel.attributedText = getAttributedTextForStat(count: following, label: "following")
	}
	
	private func getAttributedTextForStat(count: Int, label: String) -> NSMutableAttributedString {
		let attributedString = NSMutableAttributedString(string: "\(count)\n", attributes: [
			NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
		])
		
		attributedString.append(NSAttributedString(string: label, attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
			NSAttributedStringKey.foregroundColor: UIColor.lightGray
		]))
		
		return attributedString
	}
	
	private func setupEditFollowButton() {
		guard
			let user = user,
			let currentUser = Auth.auth().currentUser
		else { return }
		
		if (user.uid == currentUser.uid) {
			editProfileFollowButton.setTitle("Edit Profile", for: .normal)
			setEditFollowButtonStyle(forAction: .editProfile)
		} else {
			Database.database().reference().child("following").child(currentUser.uid).child(user.uid).observeSingleEvent(of: .value) { (snapshot) in
				if let isFollowing = snapshot.value as? Int, isFollowing == 1 {
					self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
					self.setEditFollowButtonStyle(forAction: .unfollow)
				} else {
					self.editProfileFollowButton.setTitle("Follow", for: .normal)
					self.setEditFollowButtonStyle(forAction: .follow)
				}
			}
		}
	}
	
	private func setEditFollowButtonStyle(forAction action: action) {
		switch action {
		case .follow:
			self.editProfileFollowButton.setTitleColor(.white, for: .normal)
			self.editProfileFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
			self.editProfileFollowButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
		default:
			self.editProfileFollowButton.setTitleColor(.black, for: .normal)
			self.editProfileFollowButton.layer.borderColor = UIColor.lightGray.cgColor
			self.editProfileFollowButton.backgroundColor = .white
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupProfileImage()
		setupToolbar()
		setupUsername()
        setupStats()
        setupEditProfileButton()
	}
	
	private func setupProfileImage() {
		addSubview(profileImageView)
		profileImageView.anchor(top: topAnchor, equalTo: 10)
		profileImageView.anchor(left: leftAnchor, equalTo: 10)
		profileImageView.anchor(width: 80)
		profileImageView.anchor(height: 80)
		profileImageView.layer.cornerRadius = 40
	}
	
	private func setupToolbar() {
		toolbarStackView.addArrangedSubview(gridButton)
		toolbarStackView.addArrangedSubview(listButton)
		toolbarStackView.addArrangedSubview(bookmarkButton)
		
		addSubview(toolbarStackView)
		toolbarStackView.anchor(left: leftAnchor, equalTo: 0)
		toolbarStackView.anchor(right: rightAnchor, equalTo: 0)
		toolbarStackView.anchor(bottom: bottomAnchor, equalTo: 0)
		toolbarStackView.anchor(height: 50)
        
        let topBorder = UIView()
        topBorder.backgroundColor = UIColor.lightGray
        addSubview(topBorder)
        topBorder.anchor(left: toolbarStackView.leftAnchor, equalTo: 0)
        topBorder.anchor(right: toolbarStackView.rightAnchor, equalTo: 0)
        topBorder.anchor(bottom: toolbarStackView.topAnchor, equalTo: 0)
        topBorder.anchor(height: 1)
        
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = UIColor.lightGray
        addSubview(bottomBorder)
        bottomBorder.anchor(left: toolbarStackView.leftAnchor, equalTo: 0)
        bottomBorder.anchor(right: toolbarStackView.rightAnchor, equalTo: 0)
        bottomBorder.anchor(top: toolbarStackView.bottomAnchor, equalTo: 0)
        bottomBorder.anchor(height: 1)
	}
	
	private func setupUsername() {
		addSubview(usernameLabel)
		usernameLabel.anchor(left: leftAnchor, equalTo: 10)
		usernameLabel.anchor(right: rightAnchor, equalTo: 10)
		usernameLabel.anchor(top: profileImageView.bottomAnchor, equalTo: 0)
		usernameLabel.anchor(bottom: toolbarStackView.topAnchor, equalTo: 0)
	}
    
    private func setupStats() {
        statsStackView.addArrangedSubview(postsLabel)
        statsStackView.addArrangedSubview(followersLabel)
        statsStackView.addArrangedSubview(followingLabel)
        
        addSubview(statsStackView)
        statsStackView.anchor(top: topAnchor, equalTo: 10)
        statsStackView.anchor(left: profileImageView.rightAnchor, equalTo: 10)
        statsStackView.anchor(right: rightAnchor, equalTo: 10)
        statsStackView.anchor(height: 50)
    }
    
    private func setupEditProfileButton() {
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: statsStackView.bottomAnchor, equalTo: 2)
        editProfileFollowButton.anchor(left: statsStackView.leftAnchor, equalTo: 0)
        editProfileFollowButton.anchor(right: statsStackView.rightAnchor, equalTo: 0)
        editProfileFollowButton.anchor(height: 32)
    }
}


















