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
    @IBAction func favoriteClicked(_ sender: Any) {
        if var detail = self.detailItem {
            detail.isFavorite = !detail.isFavorite
            detailItem?.isFavorite = detail.isFavorite
        
            productFavorite.setImage(UIImage(named: detail.isFavorite ? "star_filled" : "star_outline"), for: UIControlState.normal)
            
            //  Insert into favorites data store
            if detail.isFavorite {
                DataStore.sharedInstance.insertProduct(product: detailItem!)
            } else {
                //  Remove from data store
                DataStore.sharedInstance.deleteProduct(id: (detailItem?.id)!)
            }
        }
    }

    @IBAction func DoneClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if var detail = self.detailItem {
            if self.productImage == nil{
                return
            }

            let downloadURL = NSURL(string: detail.imageUrl)
            productImage.af_setImage(withURL: downloadURL as! URL)
            
            productName.text = detail.name
            productCategory.text = detail.primaryCategory
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            productDescription.text = formatter.string(from: NSNumber.init(floatLiteral: detail.price))

            detail.isFavorite = (DataStore.sharedInstance.findProduct(id: detail.id) != nil)
            productFavorite.setImage(UIImage(named: detail.isFavorite ? "star_filled" : "star_outline"), for: UIControlState.normal)
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

