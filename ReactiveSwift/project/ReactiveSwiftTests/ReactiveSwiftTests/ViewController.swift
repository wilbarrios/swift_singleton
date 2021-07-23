//
//  ViewController.swift
//  ReactiveSwiftTests
//
//  Created by Wilmer Barrios on 22/07/21.
//

import UIKit
import ReactiveSwiftTestsCoreiOS

class ViewController: UIViewController {
    
    private let textField: WBTextField = {
        WBTextField()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupObserver()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBlue
        
        let v = textField.view()
        view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemOrange
        
        NSLayoutConstraint.activate([
            v.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupObserver() {
        // Transform the signal
        let booleanSignal = textField.signal()
            .map({ $0.count > 0 }) // Has value?
        
        // Observe it
        booleanSignal.observeValues({
            print("\($0)")
        })
    }


}

