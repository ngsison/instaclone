//
//  CustomImageView.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 17/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
	
	var lastURL: String?
	
	public func loadImage(from urlString: String) {
		guard let url = URL(string: urlString) else { return }
		
		lastURL = urlString
		if let cachedImage = imageCache[urlString] {
			image = cachedImage
			return
		}
		
		image = nil
		URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
			if let error = error {
				print(error)
				return
			}
			
			if url.absoluteString != self.lastURL { return }
			
			guard let imageData = data else { return }
			let image = UIImage(data: imageData)
			
			imageCache[url.absoluteString] = image
			
			DispatchQueue.main.async(execute: {
				self.image = image
			})
		}.resume()
	}
	
}
