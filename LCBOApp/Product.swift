//
//  Product.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-23.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class Product : NSManagedObject {
    @NSManaged var id : String
    @NSManaged var name : String
    @NSManaged var price : Double
    @NSManaged var primaryCategory : String
    @NSManaged var imageUrl : String
    @NSManaged var imageThumbUrl : String
    @NSManaged var image : UIImage?
    @NSManaged var imageThumb : UIImage?
}
