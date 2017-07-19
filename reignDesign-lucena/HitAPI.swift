//
//  HitAPI.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

struct HitAPI {
    
    private static let disposeBag = DisposeBag()
    
    static func readHits() -> Observable<[Hit]> {
        
        HitsNetworkService.getHits()
            .subscribe(onNext: { (hits) in
                save(hits: hits)
                    .subscribe()
                    .addDisposableTo(disposeBag)
            })
            .addDisposableTo(disposeBag)
        
        return HitsDiskService.readHits()
    }
    
    
    private static func save(hits: [Hit]) -> Observable<Bool> {
        return HitsDiskService.save(hits: Array(hits))
    }
    
    static func delete(hit: Hit) -> Observable<Bool> {
        return HitsDiskService.delete(hit: hit)
    }
}
