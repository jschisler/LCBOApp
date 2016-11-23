//
//  FavoritesViewController.swift
//  FavoritesViewController
//
//  Created by John Schisler on 2016-11-21.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    public var dataProvider: ProductListDataProviderProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        assert(dataProvider != nil, "dataProvider should not be nil!")
        tableView.dataSource = dataProvider
        dataProvider?.tableView = tableView
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = dataProvider?.productAt(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = ProductInfo.init(entity: object! as Product)
            }
        }
    }
}

