//
//  ViewController.swift
//  ReactiveSwiftTests
//
//  Created by Wilmer Barrios on 22/07/21.
//

import UIKit
import ReactiveSwiftTestsCoreiOS
import ReactiveSwift

class ViewController: UIViewController {
    
    private let textField: WBTextField = {
        WBTextField()
    }()
    
    private let button: UIButton = {
        let b = UIButton()
        b.setTitle("ACTION", for: .normal)
        b.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        return b
    }()
    
    @objc
    private func buttonHandler() {
        print(#function)
    }

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
    
    var disposable: Disposable?
    
    private func setupObserver() {
        // Transform the signal
        let booleanSignal = textField.signal()
            .map({ $0.count > 0 }) // Has value?
        
        // Observe it
//        booleanSignal.observeValues({
//            print("\($0)")
//        })
        
        let b = self.button
        let observer = Signal<Bool, Never>.Observer(value: {
            value in
            b.isEnabled = value
        })
        
        disposable = booleanSignal.observe(observer)
    }
    
    deinit {
        disposable?.dispose()
    }
}

