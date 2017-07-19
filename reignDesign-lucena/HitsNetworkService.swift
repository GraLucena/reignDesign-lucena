//
//  HitsNetworkService.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Unbox

struct HitsNetworkService {
    
    struct Key {
        static let hits = "hits"
    }
    
    static func getHits() -> Observable<[Hit]>{
        
        return Observable.create { (observer) -> Disposable in
            
            Alamofire.request(Router.getHits())
                .validate()
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let jsonData):
                        
                        
                        guard let jsonDictionary = jsonData.toJSONDictionary(), let hits: [Hit] = try? unbox(dictionary: jsonDictionary, atKey: Key.hits) else {
                            observer.onError(ApiError.defaultError)
                            break
                        }
                        
                        observer.onNext(hits)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        let apiError = ApiError(error: error, data:  response.data) ?? .defaultError
                        observer.onError(apiError)
                    }
            }
            
            return Disposables.create()
        }
    }
}
