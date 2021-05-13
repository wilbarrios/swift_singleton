//
//  ScrollViewOneController.swift
//  ScrollApp
//
//  Created by Wilmer Barrios on 12/05/21.
//

import Foundation
import UIKit

class ScrollViewOneController: UIViewController {
    // MARK: UI Components
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .orange
        return sv
    }()
    
    private let contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        setupViews(scrollView, contentView)

        scrollView.addSubview(contentView)
        contentView.fillSuperView()
        contentView.setSize(width: view.widthAnchor)
        contentView.setSize(height: view.bounds.height + 200)
        
        scrollView.fillSuperView()
        scrollView.centerInSuperview()
        scrollView.setSize(width: view.widthAnchor)
    }
    
    private func setupViews(_ views: UIView...) {
        views.forEach({ $0.setupForAutoLayout(); view.addSubview($0) })
    }
}
