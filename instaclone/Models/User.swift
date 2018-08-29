//
//  User.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 21/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import Foundation

class User {
	var username: String?
	var profileImageURL: String?
	var posts = [Post]()
	
	init(withDictionary dictionary: [String: Any]) {
		self.username = dictionary["username"] as? String
		self.profileImageURL = dictionary["profileImageURL"] as? String
	}
}
