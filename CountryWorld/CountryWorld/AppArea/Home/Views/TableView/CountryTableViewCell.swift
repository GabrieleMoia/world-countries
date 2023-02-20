//
//  CountryTableViewCell.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 18/02/23.
//

import Foundation
import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var countryImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var continentNameLabel: UILabel!
    
    @objc public dynamic var themeTitleFont: UIFont!
    @objc public dynamic var themeTitleColor: UIColor!
    @objc public dynamic var themeSubtitleColor: UIColor!
    @objc public dynamic var themeSubtitleFont: UIFont!
    
    var countryImageUrl: String? {
        willSet {
            self.countryImageView.setImageFromStringrURL(stringUrl: newValue)
        }
    }

    var countryName: String? {
        willSet {
            self.countryNameLabel.text = newValue
        }
    }
    
    var continentName: String? {
        willSet {
            self.continentNameLabel.text = newValue
        }
    }
}
