//
//  HomeCoordinator.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    var rootViewController: UIViewController
    private var coordinators: [String: Coordinator]
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    // MARK: - Initializers
    init() {
        rootViewController = UINavigationController()
        coordinators = [:]
    }
    
    // MARK: - Coordinator
    func start() {
        let hitsListVM = HitAPIViewModel()
        hitsListVM.coordinatorDelegate = self
        let hitsListVC = HitsViewController(viewModel: hitsListVM)
        navigationController.setViewControllers([hitsListVC], animated: true)
    }
    
    fileprivate func showURLFor(hit: Hit) {
        let hitWebVM = WebAPIViewModel()
        hitWebVM.hit = hit
        let hitWebVC = WebViewController(viewModel: hitWebVM)
        hitWebVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController.pushViewController(hitWebVC, animated: true)
    }
}

//MARK: - HitsViewModelCoordinatorDelegate
extension HomeCoordinator: HitsViewModelCoordinatorDelegate{
    
    func hitViewModel(_ viewModel: HitsViewModel, didSelect hit: Hit) {
        showURLFor(hit: hit)
    }

}
