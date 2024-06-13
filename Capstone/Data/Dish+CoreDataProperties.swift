//
//  Dish+CoreDataProperties.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/10/24.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: String?
    @NSManaged public var image: String?

}

extension Dish : Identifiable {

}
