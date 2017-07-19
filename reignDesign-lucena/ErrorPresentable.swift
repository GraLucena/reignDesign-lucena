//
//  ErrorPresentable.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation

protocol ErrorPresentable: Error {
    var title: String? { get }
    var message: String? { get }
}
