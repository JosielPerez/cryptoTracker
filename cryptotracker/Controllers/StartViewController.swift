//
//  StartViewController.swift
//  cryptotracker
//
//  Created by Josiel Perez on 10/23/23.
//

import UIKit

class StartViewController: UIViewController {

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        return button
    }()
    private let titleLabel: UILabel = {
            let label = UILabel()
            return label
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        titleLabel.text = "Cryptocurrency\nTracker"
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.alpha = 0
        view.addSubview(titleLabel)

        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.alpha = 0 
        startButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        view.addSubview(startButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func didTapStartButton() {
        let tabVC = TabViewController()
        tabVC.modalPresentationStyle = .fullScreen
        present(tabVC, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.0) {
            self.startButton.alpha = 1
            self.startButton.transform = CGAffineTransform.identity

            self.titleLabel.alpha = 1
        }
    }
}
