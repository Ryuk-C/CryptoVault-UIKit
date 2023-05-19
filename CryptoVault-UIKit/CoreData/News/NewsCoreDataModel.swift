//
//  NewsCoreDataModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import CoreData
import UIKit

final class NewsCoreDataManager {
    
    static let shared = NewsCoreDataManager()

    let persistentContainer = NSPersistentContainer(name: "CryptoVaultDatabase")
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
     init() {
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func save() {
        try? self.context.save()
    }
    
    func getNews() -> [NewsDB]? {
        return try? self.context.fetch(NewsDB.fetchRequest())
    }

    func addNews(
        id: String, url: String, source: String,
        newsTitle: String, imageUrl: String, category: String
    ) {
        let news = NewsDB(context: context)
        news.id = id
        news.newsUrl = url
        news.source = source
        news.title = newsTitle
        news.imageUrl = imageUrl
        news.category = category
        save()
    }

    func deleteCryptoCurrency(index: Int) {
        if let news = getNews() {
            context.delete(news[index])
            save()
        }
    }
}
