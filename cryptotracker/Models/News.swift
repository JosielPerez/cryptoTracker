//
//  News.swift
//  cryptotracker
//
//  Created by Josiel Perez on 11/19/23.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}
