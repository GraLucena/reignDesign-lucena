//
//  HitsDiskService.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import Unbox

struct HitsDiskService {
    
    private static let disposeBag = DisposeBag()
    
    // MARK: - Properties
    private static var realm: Realm {
        return try! Realm()
    }
    
    // MARK: - API
    static func readHits() -> Observable<[Hit]> {
        
        let realmHits = realm.objects(Hit.self)
        
        return Observable.array(from: realmHits)
            .map { array in
                return array
        }
    }
    
    static func save(hits: [Hit]) -> Observable<Bool> {

        try! realm.write {
            realm.deleteAll()
        }
        
        do {
            realm.beginWrite()
            realm.add(hits, update: true)
            try realm.commitWrite()
            return Observable.just(true)
        } catch {
            return Observable.just(false)
        }
    }
    
    static func delete(hit: Hit) -> Observable<Bool> {
        
        do {
            realm.beginWrite()
            realm.delete(hit)
            try realm.commitWrite()
            return Observable.just(true)
        } catch {
            return Observable.just(false)
        }
    }

}
