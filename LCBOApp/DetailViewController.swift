//
//  DetailViewController.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-20.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productFavorite: UIButton!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Product? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

