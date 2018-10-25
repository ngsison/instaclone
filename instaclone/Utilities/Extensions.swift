//
//  Extensions.swift
//  instaclone
//
//  Created by Nathaniel SISON on 14/8/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseDatabase



// MARK: - FirebaseDatabase
extension Database {
	
	static func fetchUser(withUID uid: String, onSuccess: @escaping (User) -> Void) {
		Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
			guard let snapshotDict = snapshot.value as? [String: Any] else { return }
			let user = User(uid: uid, dictionary: snapshotDict)
			onSuccess(user)
		}
	}
	
}



// MARK: - UIColor
extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
	
	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
	}
    
}



// MARK: - UIView
extension UIView {
	
	func hideKeyboardWhenTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		addGestureRecognizer(tap)
	}
	
	@objc private func dismissKeyboard() {
		endEditing(true)
	}
	
    private func prepareToUseConstraint() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func anchor(top: NSLayoutYAxisAnchor, equalTo constant: CGFloat) {
        prepareToUseConstraint()
        topAnchor.constraint(equalTo: top, constant: constant).isActive = true
    }
    
    func anchor(bottom: NSLayoutYAxisAnchor, equalTo constant: CGFloat) {
        prepareToUseConstraint()
        bottomAnchor.constraint(equalTo: bottom, constant: -constant).isActive = true
    }
    
    func anchor(left: NSLayoutXAxisAnchor, equalTo constant: CGFloat) {
        prepareToUseConstraint()
        leftAnchor.constraint(equalTo: left, constant: constant).isActive = true
    }
    
    func anchor(right: NSLayoutXAxisAnchor, equalTo constant: CGFloat) {
        prepareToUseConstraint()
        rightAnchor.constraint(equalTo: right, constant: -constant).isActive = true
    }
    
    func anchor(height: CGFloat) {
        prepareToUseConstraint()
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func anchor(width: CGFloat) {
        prepareToUseConstraint()
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func anchor(centerX: NSLayoutXAxisAnchor) {
        prepareToUseConstraint()
        centerXAnchor.constraint(equalTo: centerX).isActive = true
    }
    
    func anchor(centerY: NSLayoutYAxisAnchor) {
        prepareToUseConstraint()
        centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
    
}



// MARK: - UIImage
extension UIImage {
    func renderOriginal() -> UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
}



// MARK: - Date
extension Date {
	func timeAgoDisplay() -> String {
		let secondsAgo = Int(Date().timeIntervalSince(self))
		
		let minute = 60
		let hour = 60 * minute
		let day = 24 * hour
		let week = 7 * day
		let month = 4 * week
		
		let quotient: Int
		let unit: String
		if secondsAgo < minute {
			quotient = secondsAgo
			unit = "second"
		} else if secondsAgo < hour {
			quotient = secondsAgo / minute
			unit = "min"
		} else if secondsAgo < day {
			quotient = secondsAgo / hour
			unit = "hour"
		} else if secondsAgo < week {
			quotient = secondsAgo / day
			unit = "day"
		} else if secondsAgo < month {
			quotient = secondsAgo / week
			unit = "week"
		} else {
			quotient = secondsAgo / month
			unit = "month"
		}
		
		return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
		
	}
}




