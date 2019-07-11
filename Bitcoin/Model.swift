// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: [BitcoinData]
}

// MARK: - Datum
struct BitcoinData: Codable {
    let id: Int
    let name, symbol, slug: String
    let circulatingSupply, totalSupply: Double
    let maxSupply: Double?
    let dateAdded: String
    let numMarketPairs: Int
    let quote : Quote
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case dateAdded = "date_added"
        case numMarketPairs = "num_market_pairs"
        case quote
    }
}


struct Quote : Codable {
    let USD : USDCoin
}

struct USDCoin: Codable {
    let price: Double
    let last_updated : String
    let market_cap : Double
}
