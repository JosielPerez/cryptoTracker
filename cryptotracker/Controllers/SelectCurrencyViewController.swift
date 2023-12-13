//
//  SelectCurrencyViewController.swift
//  cryptotracker
//
//  Created by Josiel Perez on 11/30/23.
//

import UIKit

class SelectCurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currencies = ["USD", "EUR", "GBP", "JPY"]
    var selectedCurrency: String?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "currencyCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCurrency = UserDefaults.standard.string(forKey: UserDefaultsKeys.preferredCurrency)
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = currency
        cell.accessoryType = currency == selectedCurrency ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCurrency = currencies[indexPath.row]
        UserDefaults.standard.set(selectedCurrency, forKey: "SelectedCurrency")
        tableView.reloadData()
    }
}
