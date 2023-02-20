//
//  HomeCoordinator.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 17/02/23.
//

import Foundation
import UIKit
import Combine

class HomeCoordinator: BaseCoordinator {

    private var subscriptions = Set<AnyCancellable>()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        
        viewModel.$selectedCountry.filter({ $0 != nil }).sink { country in
            let context = DetailContext(country: country)
            self.openDetail(with: context)
        }.store(in: &subscriptions)
        
        // register subscription on BaseViewModel
        self.registerForError(viewModel: viewModel, viewController: viewController)
        
        self.navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func openDetail(with context: DetailContext) {
        let viewModel = DetailViewModel(context: context)
        let viewController = DetailViewController()
        viewController.viewModel = viewModel
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
