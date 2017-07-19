//
//  Router.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire

typealias jsonDictionary = [String: AnyObject]

enum Router {
    
    // MARK: - Configuration
    static let baseHostPath = "https://hn.algolia.com/api/v1"
    static let versionPath = "/api/v1"

    var baseURLPath: String {
        return "\(Router.baseHostPath)\(Router.versionPath)"
    }
    
    case getHits()
}

extension Router {
    
    struct Request {
        let method: Alamofire.HTTPMethod
        let path: String
        let encoding: ParameterEncoding?
        let parameters: jsonDictionary?
        
        init(method: Alamofire.HTTPMethod,
             path: String,
             parameters: jsonDictionary? = nil,
             encoding: ParameterEncoding = JSONEncoding.default) {
            
            self.method = method
            self.path = path
            self.encoding = encoding
            self.parameters = parameters
        }
    }
    
    var request: Request {
        switch self {
        case .getHits():
            return Request(method: .get,
                           path: "/search_by_date?query=ios")
        }
    }
}

// MARK: - URLRequestConvertible

extension Router: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: "https://hn.algolia.com/api/v1/search_by_date?query=ios")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let encoding = request.encoding {
            return try encoding.encode(urlRequest, with: request.parameters)
        } else {
            return urlRequest
        }
    }
}
