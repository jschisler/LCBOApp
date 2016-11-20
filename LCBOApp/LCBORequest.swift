//
//  LCBORequest.swift
//  LCBOApp
//
//  Created by John Schisler on 2016-11-20.
//  Copyright © 2016 John Schisler. All rights reserved.
//

import Foundation
import Alamofire

enum ProductRequest: URLRequestConvertible {
    case search(query: String, page: Int)
    
    static let baseURLString = "https://lcboapi.com"
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case let .search(query, page) where page > 0:
                return ("/products", ["q": query, "page": page])
            case let .search(query, _):
                return ("/products", ["q": query])
            }
        }()
        
        let url = try ProductRequest.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}
