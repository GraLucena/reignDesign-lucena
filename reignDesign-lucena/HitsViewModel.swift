//
//  HitsViewModel.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import RxSwift

protocol HitsViewModelViewDelegate: class {
    func hitsDidChange(viewModel: HitsViewModel)
    func showAlertError(viewModel: HitsViewModel, error: ApiError)
}

protocol HitsViewModelCoordinatorDelegate: class {
    func hitViewModel(_ viewModel: HitsViewModel, didSelect hit: Hit)
}

protocol HitsViewModel: class {
    
    var viewDelegate: HitsViewModelViewDelegate? { get set }
    var coordinatorDelegate: HitsViewModelCoordinatorDelegate? { get set }

    var hits: [Hit]? { get set }
    
    func getHits()
    func numberOfHits() -> Int
    func hitAt(_ index: Int) -> Hit
    func selectHitAt(index: Int)
    func getDaysFrom(hit: Hit) -> String
    func delete(hit: Hit)
}

class HitAPIViewModel: HitsViewModel {
    
    var viewDelegate: HitsViewModelViewDelegate?
    var coordinatorDelegate: HitsViewModelCoordinatorDelegate?

    fileprivate let disposeBag = DisposeBag()
    
    var hits: [Hit]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.viewDelegate?.hitsDidChange(viewModel: strongSelf)
            }
        }
    }
    
    func getHits() {
        HitAPI.readHits()
            .do(onNext: { (hits) in
                self.hits?.removeAll()
                self.hits = hits
            }, onError: { (error) in
                let error = error as? ApiError ?? ApiError.defaultError
                self.viewDelegate?.showAlertError(viewModel: self, error: error)
            })
            .subscribe()
            .addDisposableTo(disposeBag)
    }
    
    func numberOfHits() -> Int {
        return hits?.count ?? 0
    }
    
    func hitAt(_ index: Int) -> Hit{
        return (hits?[index])!
    }
    
    func selectHitAt(index: Int) {
        guard let hit = hits?[index] else { return }
        coordinatorDelegate?.hitViewModel(self, didSelect: hit)
    }
    
    
    func getDaysFrom(hit: Hit) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let hitDate : Date = dateFormatter.date(from: hit.createdAt)!
        
        return Date().offset(from: hitDate)
    }
    
    func delete(hit: Hit){
        HitAPI.delete(hit: hit)
            .subscribe()
            .addDisposableTo(disposeBag)
    }
}
