//
//  WebViewModel.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation

protocol WebViewModel: class {
    
    var hit: Hit? { get set }
}

class WebAPIViewModel: WebViewModel {
    
    var hit: Hit? {
        didSet {
            
        }
    }
}
