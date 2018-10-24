//
//  User.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 21/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import Foundation

class User {
	let uid: String
	let username: String
	let profileImageURL: String
	var posts = [Post]()
	
	init(uid: String, dictionary: [String: Any]) {
		self.uid = uid
		self.username = dictionary["username"] as? String ?? ""
		self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
	}
}
