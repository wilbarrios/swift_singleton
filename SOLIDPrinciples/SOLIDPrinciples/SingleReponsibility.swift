//
//  SingleReponsibility.swift
//  SOLIDPrinciples
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import UIKit

public protocol SaveHandler {
    typealias SaveCompletionHandler = (Error?) -> Void
    func save(completion: @escaping SaveCompletionHandler)
}

final internal class SingleResponsibilityController: UIViewController {
    
    // MARK: Properties
    var saveHandler: SaveHandler!
    
    // MARK: UI Components...
    private let saveButton: UIButton = {
        let b = UIButton()
        b.setTitle("Save", for: .normal)
        b.addTarget(self, action: #selector(saveButtonHandler), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    // MARK: User Interaction
    @objc
    private func saveButtonHandler() {
        saveHandler.save(completion: processSaveCompletion(_:))
    }
    
    // MARK: Inits
    convenience init(saveHandler: SaveHandler) {
        self.init()
        self.saveHandler = saveHandler
    }
    
    // MARK: VC Life cycle...
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Helpers
    private func setupLayout() {
        let v = self.view!
        
        v.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.centerYAnchor.constraint(equalTo: v.centerYAnchor),
            saveButton.centerXAnchor.constraint(equalTo: v.centerXAnchor)
        ])
    }
    
    private func processSaveCompletion(_ error: Error?) -> Void {
        guard let _error = error else { return }
        print("Error... \(_error.localizedDescription)")
    }
}

