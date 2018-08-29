//
//  Post.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 29/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import Foundation

class Post {
	var caption: String?
	var imageURL: String?
	var imageWidth: NSNumber?
	var imageHeight: NSNumber?
	var createdOn: NSNumber?
	
	init(withDictionary dictionary: [String: Any]) {
		self.caption = dictionary["caption"] as? String
		self.imageURL = dictionary["imageURL"] as? String
		self.imageWidth = dictionary["imageWidth"] as? NSNumber
		self.imageHeight = dictionary["imageHeight"] as? NSNumber
		self.createdOn = dictionary["createdOn"] as? NSNumber
	}
}
