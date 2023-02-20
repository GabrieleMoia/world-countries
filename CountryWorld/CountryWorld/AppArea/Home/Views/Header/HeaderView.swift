//
//  HeaderView.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 19/02/23.
//

import Foundation
import UIKit

class HeaderView: AutolayoutView {
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    var title: String? {
        willSet {
            self.titleLabel.text = newValue
        }
    }
    
}
