//
//  APIService.swift
//  cryptotracker
//
//  Created by Josiel Perez on 10/16/23.
//

import Foundation

struct APIService {
    
    static let shared = APIService()
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func allCryptos() async throws -> [CryptoResponse]{
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=25&page=1&sparkline=false&locale=en&precision=2&x_cg_demo_api_key=CG-hoV4CNmvZnZfAWFjmhyjjMzz")!
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else{
            throw APIServiceError.requestFailed(message: "Response is not HTTPURLResponse.")
        }
        
        guard 200...299 ~= response.statusCode else {
            throw APIServiceError.requestFailed(message: "Status Code should be 2xx, but is \(response.statusCode).")
        }
        
        let cryptos = try JSONDecoder().decode([CryptoResponse].self, from: data)
        
        return cryptos
    }
    
    func getCrypto(named cryptoName: String) async throws -> CryptoData{
        let lowercaseCryptoName = cryptoName.lowercased()
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(lowercaseCryptoName)?localization=false&tickers=false&developer_data=false&sparkline=false&x_cg_demo_api_key=CG-hoV4CNmvZnZfAWFjmhyjjMzz")!
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else{
            throw APIServiceError.requestFailed(message: "Response is not HTTPURLResponse.")
        }
        
        guard 200...299 ~= response.statusCode else {
            throw APIServiceError.requestFailed(message: "Status Code should be 2xx, but is \(response.statusCode).")
        }
        
        let crypto = try JSONDecoder().decode(CryptoData.self, from: data)
        
        return crypto
    }
    
    func getNews() async throws -> [Article] {
        let urlString = "https://newsapi.org/v2/everything?q=cryptocurrency&apiKey=2134695b100b45e3b0e21ccfe64d0c01"
        
        guard let url = URL(string: urlString) else {
            throw APIServiceError.requestFailed(message: "Invalid URL.")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw APIServiceError.requestFailed(message: "Response is not HTTPURLResponse.")
        }
        
        guard 200...299 ~= response.statusCode else {
            throw APIServiceError.requestFailed(message: "Status Code should be 2xx, but is \(response.statusCode).")
        }
        
        let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
        
        return newsResponse.articles
    }


}


//Errors
enum APIServiceError: Error {
    case requestFailed(message: String)
}

