//
//  ProductListDataProvider.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-23.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import UIKit
import CoreData

public class ProductListDataProvider: NSObject, ProductListDataProviderProtocol {
    public var managedObjectContext: NSManagedObjectContext?
    weak public var tableView: UITableView!
    
    var _fetchedResultsController: NSFetchedResultsController<ProductEntity>? = nil
    
    public func addProduct(productInfo: ProductInfo) {
        
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let product = self.fetchedResultsController.object(at: indexPath as IndexPath)
        
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.primaryCategory
        cell.imageView?.image = product.imageThumb as! UIImage?
    }
    
    public func fetch() {
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortDescriptor]
        
        fetchedResultsController.fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        tableView.reloadData()
    }
    
    public func productAt(at: IndexPath) -> ProductEntity {
        return fetchedResultsController.object(at: at)
    }
}

extension ProductListDataProvider: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath as IndexPath)
        self.configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension ProductListDataProvider : NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<ProductEntity> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)

        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataStore.sharedInstance.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
}
