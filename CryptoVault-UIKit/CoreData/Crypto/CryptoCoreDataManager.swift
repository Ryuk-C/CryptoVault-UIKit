//
//  CryptoCoreDataHelper.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import CoreData
import UIKit

final class CryptoCoreDataManager {
    
    static let shared = CryptoCoreDataManager()

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
    
    func getCryptoCurrencies() -> [CryptoDB]? {
        return try? self.context.fetch(CryptoDB.fetchRequest())
    }

    func addCeyptoCurrency(id: String) {
        let crypto = CryptoDB(context: context)
        crypto.id = id
        save()
    }

    func deleteCryptoCurrency(index: Int) {
        if let crypt = getCryptoCurrencies() {
            context.delete(crypt[index])
            save()
        }
    }
}
