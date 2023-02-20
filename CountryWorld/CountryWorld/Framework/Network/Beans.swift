//
//  Beans.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 18/02/23.
//

import Foundation

struct Country: Codable {
    var name: CountryName?
    var flags: Flags?
    var region: String?
    var languages: [String: String]?
    var currencies: [String: Currency]?
    var capital: [String]?
    var latlng: [Double]?
    var population: Int64?
    
    struct CountryName: Codable {
        var official: String?
        var common: String?
    }
    
    struct Flags: Codable {
        var png: String?
    }
    
    struct Currency: Codable {
        var name: String?
        var symbol: String?
    }
}
