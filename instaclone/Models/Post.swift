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
	let imageWidth: NSNumber?
	let imageHeight: NSNumber?
	let createdOn: Date
	var comments = [Comment]()
	
	init(user: User, dictionary: [String: Any]) {
		self.user = user
		caption = dictionary["caption"] as? String ?? ""
		imageURL = dictionary["imageURL"] as? String ?? ""
		imageWidth = dictionary["imageWidth"] as? NSNumber
		imageHeight = dictionary["imageHeight"] as? NSNumber
		
		let secondsFrom1970 = dictionary["createdOn"] as? Double ?? 0
		createdOn = Date(timeIntervalSince1970: secondsFrom1970)
	}
}
