//
//  DetailItemView.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 19/02/23.
//

import Foundation
import UIKit

class DetailItemView: AutolayoutView {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var dividerElement: UIView!
    
    @objc public dynamic var themeDividerColor: UIColor!
    @objc public dynamic var themed: Bool = false { didSet { self.applyTheme() } }
    
    var image: UIImage? {
        willSet {
            self.imageView.image = newValue
        }
    }
    
    var title: String? {
        willSet {
            self.titleLabel.text = newValue
        }
    }
    
    var value: String? {
        willSet {
            self.valueLabel.text = newValue
        }
    }
    
    private func applyTheme() {
        self.dividerElement.backgroundColor = self.themeDividerColor
    }
}
