//
//  LiveViewController.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-20.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class LiveViewController: UITableViewController {

    var searchResults = [Product]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var validatedText: String {
        return searchController.searchBar.text!.replacingOccurrences(of: " ", with: "+").lowercased()
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(LiveViewController.updateSearchResults), name: NSNotification.Name(rawValue: "searchResultsUpdated"), object: nil)
        
        // Setup the Scope Bar
        //searchController.searchBar.scopeButtonTitles = ["All", "Beer", "Wine", "Spirits", "Coolers"]
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults() {
        searchResults = requestManager.searchResults
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = searchResults[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
            }
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
        
        cell.textLabel?.text = searchResults[indexPath.row].name
        cell.detailTextLabel?.text = searchResults[indexPath.row].primaryCategory
        
        let downloadURL = NSURL(string: searchResults[indexPath.row].imageThumbUrl)
        cell.imageView?.af_setImage(withURL: downloadURL as! URL)
        
        if indexPath.row == searchResults.count - 20 {
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

extension LiveViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        requestManager.resetSearch()
        updateSearchResults()
        requestManager.search(validatedText)
    }
}
