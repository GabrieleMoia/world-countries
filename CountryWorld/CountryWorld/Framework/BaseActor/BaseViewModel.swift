//
//  BaseViewModel.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 20/02/23.
//

import Foundation

/**
 Define common operations between every viewModel
 */
class BaseViewModel: NSObject {
    @Published var error: Error?
}
