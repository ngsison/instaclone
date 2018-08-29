//
//  ProfileHeader.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 21/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "profileHeaderCell"
	var user: User? {
		didSet {
			guard
				let username = user?.username,
				let profileImageURL = user?.profileImageURL
			else { return }
			
			usernameLabel.text = username
			profileImageView.loadImage(from: profileImageURL)
		}
	}
	
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 40
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	public let gridButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
		//button.tintColor = UIColor(white: 0, alpha: 0.2)
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
        
        let postValueText = NSAttributedString(string: "11\n", attributes: [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ])
        
        let postLabelText = NSAttributedString(string: "posts", attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
        ])
        
        var attributedText = NSMutableAttributedString(attributedString: postValueText)
        attributedText.append(postLabelText)
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        
        let postValueText = NSAttributedString(string: "0\n", attributes: [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
            ])
        
        let postLabelText = NSAttributedString(string: "followers", attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ])
        
        var attributedText = NSMutableAttributedString(attributedString: postValueText)
        attributedText.append(postLabelText)
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()

        let postValueText = NSAttributedString(string: "0\n", attributes: [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
            ])
        
        let postLabelText = NSAttributedString(string: "following", attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ])
        
        var attributedText = NSMutableAttributedString(attributedString: postValueText)
        attributedText.append(postLabelText)
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
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
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupProfileImage()
		setupToolbar()
		setupUsername()
        setupStats()
        setupEditProfileButton()
	}
	
	private func setupProfileImage() {
		self.addSubview(profileImageView)
		profileImageView.anchor(top: self.topAnchor, equalTo: 10)
		profileImageView.anchor(left: self.leftAnchor, equalTo: 10)
		profileImageView.anchor(width: 80)
		profileImageView.anchor(height: 80)
	}
	
	private func setupToolbar() {
		toolbarStackView.addArrangedSubview(gridButton)
		toolbarStackView.addArrangedSubview(listButton)
		toolbarStackView.addArrangedSubview(bookmarkButton)
		
		self.addSubview(toolbarStackView)
		toolbarStackView.anchor(left: self.leftAnchor, equalTo: 0)
		toolbarStackView.anchor(right: self.rightAnchor, equalTo: 0)
		toolbarStackView.anchor(bottom: self.bottomAnchor, equalTo: 0)
		toolbarStackView.anchor(height: 50)
        
        let topBorder = UIView()
        topBorder.backgroundColor = UIColor.lightGray
        self.addSubview(topBorder)
        topBorder.anchor(left: toolbarStackView.leftAnchor, equalTo: 0)
        topBorder.anchor(right: toolbarStackView.rightAnchor, equalTo: 0)
        topBorder.anchor(bottom: toolbarStackView.topAnchor, equalTo: 0)
        topBorder.anchor(height: 1)
        
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = UIColor.lightGray
        self.addSubview(bottomBorder)
        bottomBorder.anchor(left: toolbarStackView.leftAnchor, equalTo: 0)
        bottomBorder.anchor(right: toolbarStackView.rightAnchor, equalTo: 0)
        bottomBorder.anchor(top: toolbarStackView.bottomAnchor, equalTo: 0)
        bottomBorder.anchor(height: 1)
	}
	
	private func setupUsername() {
		self.addSubview(usernameLabel)
		usernameLabel.anchor(left: self.leftAnchor, equalTo: 10)
		usernameLabel.anchor(right: self.rightAnchor, equalTo: 10)
		usernameLabel.anchor(top: profileImageView.bottomAnchor, equalTo: 0)
		usernameLabel.anchor(bottom: toolbarStackView.topAnchor, equalTo: 0)
	}
    
    private func setupStats() {
        statsStackView.addArrangedSubview(postsLabel)
        statsStackView.addArrangedSubview(followersLabel)
        statsStackView.addArrangedSubview(followingLabel)
        
        self.addSubview(statsStackView)
        statsStackView.anchor(top: self.topAnchor, equalTo: 10)
        statsStackView.anchor(left: profileImageView.rightAnchor, equalTo: 10)
        statsStackView.anchor(right: self.rightAnchor, equalTo: 10)
        statsStackView.anchor(height: 50)
    }
    
    private func setupEditProfileButton() {
        self.addSubview(editProfileButton)
        editProfileButton.anchor(top: statsStackView.bottomAnchor, equalTo: 2)
        editProfileButton.anchor(left: statsStackView.leftAnchor, equalTo: 0)
        editProfileButton.anchor(right: statsStackView.rightAnchor, equalTo: 0)
        editProfileButton.anchor(height: 32)
    }
}


















