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
	
	let commentLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		return label
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
		
		commentLabel.attributedText = attributedText
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		backgroundColor = .white
		setupProfileImageView()
		setupCommentLabel()
	}
	
	private func setupProfileImageView() {
		addSubview(profileImageView)
		profileImageView.anchor(top: topAnchor, equalTo: 8)
		profileImageView.anchor(left: leftAnchor, equalTo: 8)
		profileImageView.anchor(width: 40)
		profileImageView.anchor(height: 40)
		profileImageView.layer.cornerRadius = 20
	}
	
	private func setupCommentLabel() {
		addSubview(commentLabel)
		commentLabel.anchor(top: topAnchor, equalTo: 4)
		commentLabel.anchor(bottom: bottomAnchor, equalTo: 4)
		commentLabel.anchor(left: profileImageView.rightAnchor, equalTo: 8)
		commentLabel.anchor(right: rightAnchor, equalTo: 4)
	}
}
