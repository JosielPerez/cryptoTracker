//
//  ViewController.swift
//  cryptotracker
//
//  Created by Josiel Perez on 10/16/23.
//

import UIKit

class TrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let assetsTitleLabel = UILabel()

    var cryptos = [CryptoResponse]()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: "cryptoCell")
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupAssetsTitleLabel()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        Task {
            do {
                let cryptos = try await APIService.shared.allCryptos()
                DispatchQueue.main.async {
                    self.cryptos = cryptos
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        }
    private func setupAssetsTitleLabel() {
        assetsTitleLabel.text = "Assets"
        assetsTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        assetsTitleLabel.textAlignment = .left
        view.addSubview(assetsTitleLabel)

        // Set up constraints for the label
        assetsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            assetsTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            assetsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            assetsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // Mark: - TableView Delegate & Data Source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return cryptos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cryptoCell", for: indexPath) as? CryptoTableViewCell else {
                fatalError("Unable to dequeue CryptoTableViewCell")
            }
        let crypto = cryptos[indexPath.row]
        cell.titleLabel.text = crypto.name
        cell.priceLabel.text = "$" + String(format: "%.2f", crypto.currentPrice)
        if let safeURL = URL(string: crypto.image){
            cell.thumbnailView.loadImage(url: safeURL )
        } else {
            cell.thumbnailView.image = UIImage(systemName: "dollarsign")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crypto = cryptos[indexPath.row]
        let detailsViewController = CryptoDetailsViewController(cryptoName: crypto.id)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

