//
//  BaseViewController.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 20/02/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureBackground()
    }
    
    private func configureNavigationBar() {
        // Add back gesture on screen
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        // Remove "back" title on back button
        self.navigationController?.navigationBar.topItem?.title = ""
        // Set white for back button
        self.navigationController?.navigationBar.tintColor = .white
        // To avoid white layer on navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // Remove line when scroll
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func configureBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [BaseViewControllerTheme.appearance().themeStartGradientColor.cgColor,
                                BaseViewControllerTheme.appearance().themeEndGradientColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

class BaseViewControllerTheme: UIView {
    @objc public dynamic var themeStartGradientColor: UIColor!
    @objc public dynamic var themeEndGradientColor: UIColor!
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
