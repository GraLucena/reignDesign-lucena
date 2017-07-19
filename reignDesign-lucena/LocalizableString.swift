//
//  LocalizableString.swift
//  reignDesign-lucena
//
//  Created by Graciela Lucena on 7/18/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation

enum LocalizableString: String {
    
    //MARK: - Global
    case ok = "Ok"
    
    //MARK: - Errors
    case connectionError = "Connection error"
    case connectionProblem = "There was a problem, please try again."
    case offlineError = "Offline error"
    case checkInternet = "Check your internet connection and try again."
    
    var localizedString: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
