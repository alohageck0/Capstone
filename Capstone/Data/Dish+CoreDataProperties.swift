//
//  Dish+CoreDataProperties.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/25/24.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var title: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var itemDescription: String?
    @NSManaged public var dishCategory: String?

    static func createDishesFrom(menuItems:[MenuItem], _ context: NSManagedObjectContext) {
        debugPrint("evv createDishesFrom")
        for menuItem in menuItems {
            debugPrint("evv menuItem: \(menuItem)")
            if !(exists(title: menuItem.title, context) ?? false) {
                let oneDish = Dish(context: context)
                oneDish.title = menuItem.title
                oneDish.price = menuItem.price
                oneDish.image = menuItem.image
                oneDish.itemDescription = menuItem.description
                oneDish.dishCategory = menuItem.category
            }
        }
    }
    
    static func exists(title: String,
                       _ context:NSManagedObjectContext) -> Bool? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return nil
            }
            return results.count > 0
        } catch (let error){
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
    private static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
}

extension Dish : Identifiable {
    
}
