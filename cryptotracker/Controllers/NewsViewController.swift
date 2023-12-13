//
//  NewsViewController.swift
//  cryptotracker
//
//  Created by Josiel Perez on 11/19/23.
//

import UIKit
import SafariServices


class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var articles = [Article]()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "articleCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto News"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        fetchNews()
    }

    private func fetchNews() {
        Task {
            do {
                let fetchedArticles = try await APIService.shared.getNews()
                DispatchQueue.main.async {
                    self.articles = fetchedArticles
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        // Configure the cell with article data
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let article = articles[indexPath.row]
            let detailVC = ArticleDetailViewController()
            detailVC.article = article
            navigationController?.pushViewController(detailVC, animated: true)
        }


//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let article = articles[indexPath.row]
//        if let url = URL(string: article.url) {
//            let safariVC = SFSafariViewController(url: url)
//            present(safariVC, animated: true)
//        } else {
//            let alert = UIAlertController(title: "Error", message: "This article can't be opened right now.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            present(alert, animated: true)
//        }
//    }

}

