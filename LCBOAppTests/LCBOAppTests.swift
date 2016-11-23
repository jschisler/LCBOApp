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
    
    var liveViewController : LiveViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        liveViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LiveViewController") as? LiveViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //class MockDataProvider: NSObject, Product
}
