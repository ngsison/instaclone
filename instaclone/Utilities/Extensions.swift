//
//  Extensions.swift
//  instaclone
//
//  Created by Nathaniel SISON on 14/8/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit


// MARK: UIColor
extension UIColor {
    
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}



// MARK: UIView
extension UIView {
    
    private func prepareToUseConstraint() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func anchor(top: NSLayoutYAxisAnchor, equalTo constant: CGFloat) {
        self.prepareToUseConstraint()
        self.topAnchor.constraint(equalTo: top, constant: constant).isActive = true
    }
    
    func anchor(bottom: NSLayoutYAxisAnchor, equalTo constant: CGFloat) {
        self.prepareToUseConstraint()
        self.bottomAnchor.constraint(equalTo: bottom, constant: constant).isActive = true
    }
    
    func anchor(left: NSLayoutXAxisAnchor, equalTo constant: CGFloat) {
        self.prepareToUseConstraint()
        self.leftAnchor.constraint(equalTo: left, constant: constant).isActive = true
    }
    
    func anchor(right: NSLayoutXAxisAnchor, equalTo constant: CGFloat) {
        self.prepareToUseConstraint()
        self.rightAnchor.constraint(equalTo: right, constant: constant).isActive = true
    }
    
    func anchor(height: CGFloat) {
        self.prepareToUseConstraint()
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func anchor(width: CGFloat) {
        self.prepareToUseConstraint()
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func anchor(centerX: NSLayoutXAxisAnchor) {
        self.prepareToUseConstraint()
        self.centerXAnchor.constraint(equalTo: centerX).isActive = true
    }
    
    func anchor(centerY: NSLayoutYAxisAnchor) {
        self.prepareToUseConstraint()
        self.centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
}
