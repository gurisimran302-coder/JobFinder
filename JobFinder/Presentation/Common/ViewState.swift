//
//  ViewState.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}
