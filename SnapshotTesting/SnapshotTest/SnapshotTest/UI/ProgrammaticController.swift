//
//  ProgrammaticController.swift
//  SnapshotTest
//
//  Created by Wilmer Barrios on 10/05/21.
//

import Foundation
import UIKit

// MARK: Content constants
fileprivate struct CC {
    static var FONT_SIZE: CGFloat { 18 }
}

internal final class ProgrammaticController: UIViewController {
    
    // MARK: UI Components
    lazy var label: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: CC.FONT_SIZE)
        l.text = text
        return l
    }()
    
    // Content Values
    private var text: String?
    
    // MARK: INIT
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    // MARK: VC Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubviews(label)
        label.centerInSuperView()
    }
}
