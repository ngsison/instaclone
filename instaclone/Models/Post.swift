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
	let caption: String
	let imageURL: String
	let imageWidth: NSNumber?
	let imageHeight: NSNumber?
	let createdOn: NSNumber?
	
	init(user: User, dictionary: [String: Any]) {
		self.user = user
		self.caption = dictionary["caption"] as? String ?? ""
		self.imageURL = dictionary["imageURL"] as? String ?? ""
		self.imageWidth = dictionary["imageWidth"] as? NSNumber
		self.imageHeight = dictionary["imageHeight"] as? NSNumber
		self.createdOn = dictionary["createdOn"] as? NSNumber
	}
}
