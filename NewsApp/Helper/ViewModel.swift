//
//  ViewModel.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import Foundation

typealias State = ((_ state: ViewModelState) -> ())

class ViewModel {
    //MARK: - Properties
    var state: ViewModelState = .empty {
        didSet {
            stateChanged?(self.state)
        }
    }
    
    //MARK: - Closures
    var stateChanged: State?
}

enum ViewModelState {
    case normal
    case loading
    case empty
    case error(Error?)
}
