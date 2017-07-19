//
//  Coordinator.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

typealias CoordinatorsDictionary = [String: Coordinator]

protocol Coordinator: class {
    var rootViewController: UIViewController { get }
    
    func start()
}

extension Coordinator {
    var name: String {
        return String(describing: self)
    }
}
