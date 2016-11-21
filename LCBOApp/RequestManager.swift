import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {
    
    var searchResults = [Product]()
    
    var pageString: String {
        if pageNumber == 1 {
            return ""
        } else {
            return "page=\(pageNumber)&"
        }
    }
    
    var pageNumber = 1
    var hasMore = false
    
    func search(_ searchText: String) {
        let url = "https://lcboapi.com/products?\(pageString)q=\(searchText)"
        print(url)

        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Authorization"] = //"Token MDo2YmU0Y2Y4Yy1hZTk5LTExZTYtYmJlYi1jZjBiZWMxNDEzNzY6SnVYTEdxa0xZT2lwTU55ZkdKU2pHaTkxblZqMDliNnJpdVNE"
        "Token MDoyN2JjMTVlNC1hZjU4LTExZTYtODYyNi0xN2YwMTRlNWVkYzQ6R3BxSkE5TWhtNVo3U2FCRUFLYUliMkxFYm11QUtVWDdTbTVh"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON {
            response in
            if let results = response.result.value as? [String:AnyObject] {
                print("Results: \(results)")

                let items = JSON(results["result"]!).arrayValue
                var products = [Product]()
                
                for item in items {
                    let product = Product.init(
                        name : item["name"].stringValue,
                        price : Double.init(item["price_in_cents"].int! / 100),
                        primaryCategory : item["primary_category"].stringValue,
                        imageUrl : item["image_url"].stringValue,
                        imageThumbUrl : item["image_thumb_url"].stringValue
                    );
                    
                    products.append(product)
                }

                let pager = JSON(results["pager"]!)

                self.hasMore = pager["is_final_page"].boolValue
                self.searchResults += products
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchResultsUpdated"), object: nil)
            }
        }
    }
    
    func getNextPage(_ searchText: String) {
        pageNumber += 1
        search(searchText)
    }
    
    func resetSearch() {
        searchResults = []
    }
}
