//
//  CryptoDetailsViewController.swift
//  cryptotracker
//
//  Created by Josiel Perez on 11/16/23.
//

import UIKit

class CryptoDetailsViewController: UIViewController {
    
    private let cryptoName: String
    private var cryptoData: CryptoData?
    private var selectedCurrency: String?


    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: "cryptoCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageCell")

        return tableView
    }()
    
    init(cryptoName: String){
        self.cryptoName = cryptoName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "DescriptionCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        Task {
            do {
                let cryptoDetail = try await APIService.shared.getCrypto(named: self.cryptoName.lowercased())
                DispatchQueue.main.async {
                    self.cryptoData = cryptoDetail
                    self.tableView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching details: \(error)")
                    self.tableView.reloadData()
                }
            }
        }
        selectedCurrency = UserDefaults.standard.string(forKey: "SelectedCurrency") ?? "usd"

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedCurrency = UserDefaults.standard.string(forKey: "SelectedCurrency") ?? "usd"
        tableView.reloadData()
    }

    
    
//32:22
}

extension CryptoDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [0, 1]:
            return 200
        case [2, 0]:
            return 400
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "defaultCell")
        switch indexPath {
        case [0, 0]:
            cell.textLabel?.text = cryptoData?.name
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        case [0, 1]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageTableViewCell else {
                   fatalError("Unable to dequeue ImageTableViewCell")
               }
               if let imageUrlString = cryptoData?.image.large, let imageUrl = URL(string: imageUrlString) {
                   URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                       if let data = data {
                           DispatchQueue.main.async {
                               cell.largeImageView.image = UIImage(data: data)
                           }
                       }
                   }.resume()
               }
               return cell
            
        case [0, 2]:
            cell.textLabel?.text = "Current Price"
                    if let currencyCode = selectedCurrency,
                       let currentPrice = cryptoData?.marketData.currentPrice[currencyCode.lowercased()] {
                        let symbol = CurrencySymbol.symbols[currencyCode] ?? ""
                        cell.detailTextLabel?.text = "\(symbol)\(String(format: "%.2f", currentPrice))"
                    } else {
                        cell.detailTextLabel?.text = "Loading..."
                    }
        case [0,3]:
            cell.textLabel?.text = "All Time High"
            if let currencyCode = selectedCurrency,
               let atp = cryptoData?.marketData.ath[currencyCode.lowercased()]{
                let symbol = CurrencySymbol.symbols[currencyCode] ?? ""
                cell.detailTextLabel?.text = "\(symbol)\(String(format: "%.2f", atp))"
            }
        case [1,0]:
            cell.textLabel?.text = "Ranking"
            if let ranking = cryptoData?.marketCapRank{
                cell.detailTextLabel?.text = String(format: "%d", ranking)
            }
        case [1,1]:
            cell.textLabel?.text = "Origin Date"
            cell.detailTextLabel?.text = cryptoData?.genesisDate ?? "Unknown"
        case [2,0]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionTableViewCell else {
                fatalError("Unable to dequeue DescriptionTableViewCell")
            }
            cell.descriptionLabel.text = cryptoData?.description.en
            return cell
        default:
            break
        }
        return cell
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
}


