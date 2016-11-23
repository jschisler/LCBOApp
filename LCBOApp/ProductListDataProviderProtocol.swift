//
//  ProductListDataProviderProtocol.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-23.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import UIKit
import CoreData

public protocol ProductListDataProviderProtocol : UITableViewDataSource {
    var managedObjectContext: NSManagedObjectContext? { get set }
    weak var tableView: UITableView! { get set }
    
    func fetch()
    func productAt(at: IndexPath) -> ProductEntity
}
