//
//  CryptoDetailModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 15/05/2023.
//

import Foundation

struct CryptoDetailModel: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let blockTimeInMinutes: Int?
    let categories: [String]?
    let localization, description: Tion?
    let links: Links
    let image: ImageList?
    let countryOrigin: String?
    let genesisDate: String?
    let watchlistPortfolioUsers, marketCapRank: Int?
    let coingeckoRank: Int?
    let marketData: MarketData?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case blockTimeInMinutes = "block_time_in_minutes"
        case categories
        case localization, description, links, image
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case watchlistPortfolioUsers = "watchlist_portfolio_users"
        case marketCapRank = "market_cap_rank"
        case coingeckoRank = "coingecko_rank"
        case marketData = "market_data"
        case lastUpdated = "last_updated"
    }
}

// MARK: - Tion
struct Tion: Codable {
    let en: String?

    enum CodingKeys: String, CodingKey {
        case en
    }
}

// MARK: - Image
struct ImageList: Codable {
    let thumb, small, large: String?
}

// MARK: - Links
struct Links: Codable {
    let homepage: [String]

    enum CodingKeys: String, CodingKey {
        case homepage
    }
}

// MARK: - ReposURL
struct ReposURL: Codable {
    let github: [String]?
    let bitbucket: [JSONAny]?
}

// MARK: - MarketData
struct MarketData: Codable {
    let currentPrice: [String: Double]?
    let ath, athChangePercentage: [String: Double]?
    let athDate: [String: String]?
    let atl, atlChangePercentage: [String: Double]?
    let atlDate: [String: String]?
    let marketCap: [String: Double]?
    let marketCapRank: Int?
    let fullyDilutedValuation, totalVolume, high24H, low24H: [String: Double]?
    let priceChange24H, priceChangePercentage24H, priceChangePercentage7D, priceChangePercentage14D: Double?
    let priceChangePercentage30D, priceChangePercentage60D, priceChangePercentage200D, priceChangePercentage1Y: Double?
    let marketCapChangePercentage24H: Double?
    let priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: [String: Double]?
    let priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: [String: Double]?
    let priceChangePercentage1YInCurrency, marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case priceChangePercentage7D = "price_change_percentage_7d"
        case priceChangePercentage14D = "price_change_percentage_14d"
        case priceChangePercentage30D = "price_change_percentage_30d"
        case priceChangePercentage60D = "price_change_percentage_60d"
        case priceChangePercentage200D = "price_change_percentage_200d"
        case priceChangePercentage1Y = "price_change_percentage_1y"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case priceChange24HInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
        case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
        case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
    }
}

typealias CryptoDetailList = [CryptoDetailModel]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() { }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(
        from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
