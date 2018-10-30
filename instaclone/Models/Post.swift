//
//  Post.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 29/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import Foundation

class Post {
	let user: User
	var postID: String?
	let caption: String
	let imageURL: String
	let createdOn: Date
	var comments = [Comment]()
	var isLikedByMe = false
	
	init(user: User, dictionary: [String: Any]) {
		self.user = user
		caption = dictionary["caption"] as? String ?? ""
		imageURL = dictionary["imageURL"] as? String ?? ""
		
		let secondsFrom1970 = dictionary["createdOn"] as? Double ?? 0
		createdOn = Date(timeIntervalSince1970: secondsFrom1970)
	}
}
