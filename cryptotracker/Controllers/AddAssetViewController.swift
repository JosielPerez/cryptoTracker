//
//  AddAssetViewController.swift
//  cryptotracker
//
//  Created by Josiel Perez on 11/4/23.
//

import UIKit

class AddAssetViewController: UIViewController {
    
    let assetTextField = UITextField()
    let addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        assetTextField.borderStyle = .roundedRect
        assetTextField.placeholder = "Enter Cryptocurrency Name"
        assetTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(assetTextField)
        
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .purple
        addButton.layer.cornerRadius = 5
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            assetTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            assetTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            assetTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addButton.topAnchor.constraint(equalTo: assetTextField.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add target for button
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        // Implement the logic to add a new asset
        print("Add button tapped")
    }
}
