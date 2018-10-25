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
		caption = dictionary["caption"] as? String ?? ""
		imageURL = dictionary["imageURL"] as? String ?? ""
		imageWidth = dictionary["imageWidth"] as? NSNumber
		imageHeight = dictionary["imageHeight"] as? NSNumber
		createdOn = dictionary["createdOn"] as? NSNumber
	}
}
