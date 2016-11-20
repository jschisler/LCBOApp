//
//  MasterViewController.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-20.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class MasterViewController: UITableViewController {

    var searchResults = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var validatedText: String {
        return searchController.searchBar.text!.replacingOccurrences(of: " ", with: "+").lowercased()
    }
    
    var detailViewController: DetailViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    let requestManager = RequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Enter product..."
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(MasterViewController.updateSearchResults), name: NSNotification.Name(rawValue: "searchResultsUpdated"), object: nil)
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Beer", "Wine", "Spirits", "Coolers"]
        tableView.tableHeaderView = searchController.searchBar
        
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func updateSearchResults() {
        searchResults = requestManager.searchResults
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
         //   if let indexPath = self.tableView.indexPathForSelectedRow {
         //   let object = self.fetchedResultsController.object(at: indexPath)
           //     let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            //    controller.detailItem = object
            //    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
             //   controller.navigationItem.leftItemsSupplementBackButton = true
        //    }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        cell.textLabel?.text = searchResults[indexPath.row]["name"].stringValue
        cell.detailTextLabel?.text = searchResults[indexPath.row]["primary_category"].stringValue
        
        let downloadURL = NSURL(string: searchResults[indexPath.row]["image_thumb_url"].stringValue)!
        cell.imageView?.af_setImage(withURL: downloadURL as URL)
        
        if indexPath.row == searchResults.count - 10 {
            if requestManager.hasMore {
                requestManager.getNextPage(validatedText)
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MasterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        requestManager.resetSearch()
        updateSearchResults()
        requestManager.search(validatedText)
    }
}
