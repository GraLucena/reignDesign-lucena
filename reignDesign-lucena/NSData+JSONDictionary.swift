//
//  NSData+JSONDictionary.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation

extension Data {
    func toJSONDictionary() -> [String: AnyObject]? {
        
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else{
            return nil
        }
        
        guard let jsonDic = json as? [String: AnyObject] else {
            return nil
        }
        return jsonDic
    }
    
    var apiErrorMessage: String? {
        if let jsonDic = toJSONDictionary(),
            let errorMessage = jsonDic["message"] as? String {
            return errorMessage
        }
        
        return nil
    }
    
    var apiErrorCode: Int? {
        if let jsonDic = toJSONDictionary(),
            let errorCode = jsonDic["code"] as? Int {
            return errorCode
        }
        
        return nil
    }
}
