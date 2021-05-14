//
//  UIView+Extensions.swift
//  ScrollApp
//
//  Created by Wilmer Barrios on 12/05/21.
//

import Foundation
import UIKit

fileprivate typealias Constraint = NSLayoutConstraint

extension UIView {
    func setupForAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fillSuperView() {
        anchor(
            top: superview?.topAnchor,
            leading: superview?.leadingAnchor,
            bottom: superview?.bottomAnchor,
            trailing: superview?.trailingAnchor
        )
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil) {
        var constraints = [Constraint]()
        if let top = top { constraints.append(topAnchor.constraint(equalTo: top)) }
        if let leading = leading { constraints.append(leadingAnchor.constraint(equalTo: leading)) }
        if let bottom = bottom { constraints.append(bottomAnchor.constraint(equalTo: bottom)) }
        if let trailing = trailing { constraints.append(trailingAnchor.constraint(equalTo: trailing)) }
        constraints.activate()
    }
    
    func setSize(width: CGFloat? = nil, height: CGFloat? = nil) {
        var constraints = [Constraint]()
        if let width = width { constraints.append(widthAnchor.constraint(equalToConstant: width)) }
        if let height = height { constraints.append(heightAnchor.constraint(equalToConstant: height)) }
        constraints.activate()
    }
    
    func setSize(width: NSLayoutDimension? = nil, widthConstant: CGFloat? = nil, height: NSLayoutDimension? = nil, heightConstant: CGFloat? = nil) {
        var constraints = [Constraint]()
        if let width = width { constraints.append(widthAnchor.constraint(equalTo: width, constant: widthConstant.orZero)) }
        if let height = height { constraints.append(heightAnchor.constraint(equalTo: height, constant:  heightConstant.orZero)) }
        constraints.activate()
    }
    
    func centerInSuperview() {
        var constraints = [Constraint]()
        if let centerY = superview?.centerYAnchor { constraints.append(centerYAnchor.constraint(equalTo: centerY)) }
        if let centerX = superview?.centerXAnchor { constraints.append(centerXAnchor.constraint(equalTo: centerX)) }
        constraints.activate()
    }
}

fileprivate extension Optional where Wrapped: Numeric {
    var orZero: Wrapped { self ?? 0 }
}

fileprivate extension Array where Element == Constraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}
