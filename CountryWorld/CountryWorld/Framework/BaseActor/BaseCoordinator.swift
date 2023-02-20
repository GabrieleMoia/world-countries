//
//  BaseCoordinator.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 20/02/23.
//

import Foundation
import UIKit
import Combine

/**
 Manage eventually all common subscriptions
 If the project has an expantion, this would be very usefull
 */
class BaseCoordinator: NSObject {
    
    private var subscriptions = Set<AnyCancellable>()
    
    func registerForError(viewModel: BaseViewModel, viewController: UIViewController) {
        viewModel.$error.filter({ $0 != nil }).sink { error in
            self.showErrorAlert(with: error!, from: viewController)
        }.store(in: &subscriptions)
    }
    
    private func showErrorAlert(with error: Error, from currentPresented: UIViewController) {
        // Execute on the main thread cause crash
        DispatchQueue.main.async {
            let alert = UIAlertController(title: String(localized: "error_title"), message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: String(localized: "error_close"), style: .default, handler: nil))
            currentPresented.present(alert, animated: true)
        }
    }
}
