//
//  DataStore.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-21.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import Foundation
import CoreData

class DataStore
{
    static let sharedInstance = DataStore()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "LCBOApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    public var viewContext: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext;
        }
    }

    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertProduct(product: Product) {
        let context = persistentContainer.viewContext
        let newProduct = ProductEntity(context: context)
        
        // If appropriate, configure the new managed object.
        newProduct.id = product.id
        newProduct.imageThumbUrl = product.imageThumbUrl
        newProduct.imageUrl = product.imageUrl
        newProduct.name = product.name
        newProduct.price = product.price
        newProduct.primaryCategory = product.primaryCategory
        newProduct.imageThumb = product.imageThumb
        newProduct.image = product.image
        
        // Save the context.
        do {
            try newProduct.managedObjectContext?.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func deleteProduct(id: String) {
        let context = persistentContainer.viewContext
        
        do {
            context.delete(findProduct(id: id)!)
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func findProduct(id: String) -> ProductEntity? {
        let context = persistentContainer.viewContext
        
        do {
            // Initialize Fetch Request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            
            // Create Entity Description
            let entityDescription = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context)
            
            // Configure Fetch Request
            fetchRequest.entity = entityDescription
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            var objects: [ProductEntity]
            try objects = context.fetch(fetchRequest) as! [ProductEntity]
            
            return objects.count == 0 ? nil : objects[0]
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
