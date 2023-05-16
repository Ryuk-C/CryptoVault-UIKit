//
//  CryptoDB+CoreDataProperties.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 16/05/2023.
//
//

import Foundation
import CoreData


extension CryptoDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CryptoDB> {
        return NSFetchRequest<CryptoDB>(entityName: "CryptoDB")
    }

    @NSManaged public var id: Int16

}

extension CryptoDB : Identifiable {

}
