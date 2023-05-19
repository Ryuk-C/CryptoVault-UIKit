//
//  NewsDB+CoreDataProperties.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 16/05/2023.
//
//

import CoreData
import Foundation

extension NewsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsDB> {
        return NSFetchRequest<NewsDB>(entityName: "NewsDB")
    }

    @NSManaged public var id: String?
    @NSManaged public var newsUrl: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var source: String?
    @NSManaged public var category: String?
    @NSManaged public var title: String?
}

extension NewsDB: Identifiable {
}
