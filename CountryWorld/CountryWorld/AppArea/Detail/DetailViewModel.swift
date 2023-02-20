//
//  DetailViewModel.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 17/02/23.
//

import Foundation
import UIKit

struct DetailContext {
    var country: Country?
}

struct DetailItem {
    var image: UIImage?
    var title: String?
    var value: String?
}

class DetailViewModel: NSObject {
 
    @Published private(set) var country: Country?
    @Published private(set) var items: [DetailItem]?

    init(context: DetailContext) {
        super.init()
        self.country = context.country
        self.configureItems(context.country)
    }
    
    private func configureItems(_ country: Country?) {
        var items: [DetailItem] = []
        if let capital = country?.capital?.first {
            items.append(DetailItem(image: UIImage(named: "location"), title: String(localized: "detail_capital"), value: capital))
        }
        
        if let currency = country?.currencies?.first?.value.name {
            items.append(DetailItem(image: UIImage(named: "currency"), title: String(localized: "detail_currency"), value: currency))
        }
        
        if let languages = country?.languages?.values, languages.count > 0 {
            var spokenLanguages = ""
            languages.enumerated().forEach { (index, value) in
                spokenLanguages += index == 0 ? value : ", \(value)"
            }
            
            items.append(DetailItem(image: UIImage(named: "language"), title: String(localized: "detail_languages"), value: spokenLanguages))
        }
        
        if let population = country?.population {
            items.append(DetailItem(image: UIImage(named: "population"), title: String(localized: "detail_populations"), value: String(population)))
        }
        
        self.items = items
    }
    
}
