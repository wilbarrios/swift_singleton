//
//  ViewController.swift
//  ReactiveSwiftTestsCoreiOS
//
//  Created by Wilmer Barrios on 22/07/21.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

public final class WBTextField {
    private lazy var textField: UITextField = {
        return UITextField()
    }()
    
    public init() { }
    
    // MARK: public functions
    public func view() -> UIView {
        textField
    }
    
    public func signal() -> Signal<String, Never> {
        textField.reactive.continuousTextValues
    }
}
