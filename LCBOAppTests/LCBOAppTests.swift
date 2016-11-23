//
//  LCBOAppTests.swift
//  LCBOAppTests
//
//  Created by John Schisler on 2016-11-20.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import XCTest
import CoreData
@testable import LCBOApp

class LCBOAppTests: XCTestCase {
    
    var liveViewController : FavoritesViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        liveViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController
    }
    
    func testDataProviderHasTableViewPropertySetAfterLoading() {
        //  Given
        let mockDataProvider = MockDataProvider()
        liveViewController?.dataProvider = mockDataProvider
        
        //  When
        XCTAssertNil(mockDataProvider.tableView, "Before loading the tableview should be nil")
        
        let _ = liveViewController?.view
      
        //  Then
        XCTAssertTrue(mockDataProvider.tableView != nil, "tablewView should be set at this point")
        XCTAssert(mockDataProvider.tableView == liveViewController?.tableView, "tableView should be set to the tableView of the data source")
        XCTAssertTrue(liveViewController?.tableView?.dataSource != nil, "tableView data source should be set")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //class MockDataProvider: NSObject, Product
}

class MockDataProvider : NSObject, ProductListDataProviderProtocol {
    var managedObjectContext: NSManagedObjectContext?
    weak var tableView: UITableView!
    
    func fetch() {
    }
    func productAt(at: IndexPath) -> ProductEntity {
        return ProductEntity()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
