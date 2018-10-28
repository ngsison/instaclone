//
//  Comment.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 28/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import Foundation

class Comment {
	let user: User
	let userID: String
	let comment: String
	
	init(user: User, dictionary: [String: Any]) {
		self.user = user
		userID = dictionary["userID"] as? String ?? ""
		comment = dictionary["comment"] as? String ?? ""
	}
}
