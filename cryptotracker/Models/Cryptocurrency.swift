//
//  Cryptocurrency.swift
//  cryptotracker
//
//  Created by Josiel Perez on 10/16/23.
//

import Foundation


struct CryptoResponse: Codable {
    let id, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, totalVolume: Int
    let fullyDilutedValuation: Int?
    let high24H, low24H: Double
    let priceChange24H, priceChangePercentage24H: Double
    let marketCapChange24H: Double
    let marketCapChangePercentage24H: Double
    let circulatingSupply, ath: Double
    let totalSupply: Double?
    let maxSupply: Double?
    let athChangePercentage: Double
    let athDate: String
    let atl, atlChangePercentage: Double
    let atlDate: String
    let lastUpdated: String
    

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
    }

}

struct CryptoData: Codable {
    let id, symbol, name: String
    let description: Description
    let image: Image
    let countryOrigin: String
    let genesisDate: String?
    let marketCapRank, coingeckoRank: Int
    let marketData: MarketData

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, image
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case marketCapRank = "market_cap_rank"
        case coingeckoRank = "coingecko_rank"
        case marketData = "market_data"
    }
}

// MARK: - Description
struct Description: Codable {
    let en: String
}

// MARK: - Image
struct Image: Codable {
    let thumb, small, large: String
}

// MARK: - MarketData
struct MarketData: Codable {
    let currentPrice, ath: [String: Double]

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case ath
    }
}

struct UserDefaultsKeys {
    static let preferredCurrency = "preferredCurrency"
}
