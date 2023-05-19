//
//  NewsModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let type: Int
    let message: String
    let data: [Datum]
    let rateLimit: RateLimit
    let hasWarning: Bool

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case message = "Message"
        case data = "Data"
        case rateLimit = "RateLimit"
        case hasWarning = "HasWarning"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: String
    let guid: String
    let publishedOn: Int
    let imageurl: String
    let title: String
    let url: String
    let body, tags: String
    let lang: String
    let upvotes, downvotes, categories: String
    let sourceInfo: SourceInfo
    let source: String

    enum CodingKeys: String, CodingKey {
        case id, guid
        case publishedOn = "published_on"
        case imageurl, title, url, body, tags, lang, upvotes, downvotes, categories
        case sourceInfo = "source_info"
        case source
    }
}

// MARK: - SourceInfo
struct SourceInfo: Codable {
    let name: String
    let img: String
    let lang: String
}

// MARK: - RateLimit
struct RateLimit: Codable {
}
