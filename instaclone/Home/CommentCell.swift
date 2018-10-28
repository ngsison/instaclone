//
//  CommentCell.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 28/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CommentCell: UICollectionViewCell {
	
	
	
	// MARK: - Properties
	static let identifier = "commentCell"
	
	var comment: Comment? {
		didSet {
			guard let comment = comment else { return }
			
			setupAttributedComment()
			profileImageView.loadImage(from: comment.user.profileImageURL)
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
	
	let commentTextView: UITextView = {
		let textView = UITextView()
		textView.isScrollEnabled = false
		return textView
	}()
	
	
	
	// MARK: - Overrides
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	// MARK: - Functions
	private func setupAttributedComment() {
		guard let comment = comment else { return }
		
		let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [
			NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
		])
		
		attributedText.append(NSAttributedString(string: " \(comment.comment)", attributes: [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)
		]))
		
		commentTextView.attributedText = attributedText
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupProfileImageView()
		setupCommentLabel()
		configureSeparatorView()
	}
	
	private func setupProfileImageView() {
		addSubview(profileImageView)
		profileImageView.anchor(top: topAnchor, equalTo: 8)
		profileImageView.anchor(left: leftAnchor, equalTo: 8)
		profileImageView.anchor(width: 32)
		profileImageView.anchor(height: 32)
		profileImageView.layer.cornerRadius = 16
	}
	
	private func setupCommentLabel() {
		addSubview(commentTextView)
		commentTextView.anchor(top: topAnchor, equalTo: 0)
		commentTextView.anchor(bottom: bottomAnchor, equalTo: 4)
		commentTextView.anchor(left: profileImageView.rightAnchor, equalTo: 8)
		commentTextView.anchor(right: rightAnchor, equalTo: 4)
	}
	
	private func configureSeparatorView() {
		let lineSeparatorView = UIView()
		lineSeparatorView.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
		
		addSubview(lineSeparatorView)
		lineSeparatorView.anchor(bottom: bottomAnchor, equalTo: 0)
		lineSeparatorView.anchor(left: commentTextView.leftAnchor, equalTo: 0)
		lineSeparatorView.anchor(right: rightAnchor, equalTo: 0)
		lineSeparatorView.anchor(height: 0.5)
	}
}
