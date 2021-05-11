//
//  UIView+Exentensions.swift
//  SnapshotTest
//
//  Created by Wilmer Barrios on 10/05/21.
//

import Foundation
import UIKit

internal extension UIView {
    // MARK: Base
    static func activate(_ constraints: NSLayoutConstraint...) {
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupForAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach({ $0.setupForAutoLayout(); addSubview($0) })
    }
    
    // MARK: Alignment
    func centerInSuperView() {
        guard let sv = superview else { return }
        UIView.activate(
            centerYAnchor.constraint(equalTo: sv.centerYAnchor)
            , centerXAnchor.constraint(equalTo: sv.centerXAnchor)
        )
    }
}
