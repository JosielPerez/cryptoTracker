//
//  SettingsViewController.swift
//  cryptotracker
//
//  Created by Josiel Perez on 10/16/23.
//

import UIKit


class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        // Set up table view
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    
    // MARK: - TableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // Now you have 3 rows
    }
    private func handleSelectCurrency() {
        let selectCurrencyVC = SelectCurrencyViewController()
        navigationController?.pushViewController(selectCurrencyVC, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Add Asset"
        case 1:
            cell.textLabel?.text = "Select Currency" // Added this new option
        case 2:
            cell.textLabel?.text = "Crypto News"
        default:
            break
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            handleAddAsset()
        case 1:
            handleSelectCurrency()
        case 2:
            handleNews()
        default:
            break
        }
    }

    
    private func handleAddAsset() {
        let addAssetVC = AddAssetViewController()
        addAssetVC.modalPresentationStyle = .fullScreen
        present(addAssetVC, animated: true, completion: nil)
    }
    
    func saveSelectedCurrency(currency: String) {
        UserDefaults.standard.set(currency, forKey: "SelectedCurrency")
    }

    
    private func handleNews() {
           let newsVC = NewsViewController()
           navigationController?.pushViewController(newsVC, animated: true)
       }
    
    
}

