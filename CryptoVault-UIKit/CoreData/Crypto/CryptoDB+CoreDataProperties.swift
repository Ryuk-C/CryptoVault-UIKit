//
//  CryptoDB+CoreDataProperties.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 16/05/2023.
//
//

import CoreData
import Foundation

extension CryptoDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CryptoDB> {
        return NSFetchRequest<CryptoDB>(entityName: "CryptoDB")
    }

    @NSManaged public var id: String
}

extension CryptoDB: Identifiable {
}
