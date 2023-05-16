//
//  NewsDB+CoreDataProperties.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 16/05/2023.
//
//

import Foundation
import CoreData


extension NewsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsDB> {
        return NSFetchRequest<NewsDB>(entityName: "NewsDB")
    }

    @NSManaged public var id: String?
    @NSManaged public var newsUrl: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var source: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?

}

extension NewsDB : Identifiable {

}
