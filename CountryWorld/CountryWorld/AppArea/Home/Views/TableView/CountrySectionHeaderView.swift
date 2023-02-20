//
//  CountrySectionHeaderView.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 18/02/23.
//

import Foundation
import UIKit

class CountrySectionHeaderView: AutolayoutView {
    
    @IBOutlet private var titleLabel: UILabel!
    
    @objc public dynamic var themeBackgroundColor: UIColor!
    @objc public dynamic var themed: Bool = false { didSet { self.applyTheme() } }
    
    var title: String? {
        willSet {
            self.titleLabel.text = newValue
        }
    }
    
    private func applyTheme() {
        self.backgroundColor = self.themeBackgroundColor
    }
}
