//
//  HomeViewModel.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 17/02/23.
//

import Foundation
import Combine

struct CountriesSection {
    var header: String
    var countries: [Country]
}

class HomeViewModel: BaseViewModel {
    
    @Published private(set) var countrySections: [CountriesSection]?
    @Published private(set) var selectedCountry: Country?

    private var countries: [Country] = []
    
    override init() {
        super.init()
        self.fetch()
    }
    
    func openDetail(country: Country) {
        self.selectedCountry = country
    }
    
    func filterCountries(value: String) {
        guard value.count > 0 else {
            self.countrySections = self.retrieveSections(self.countries)
            return
        }
        
        /**
         I could have called APIs https://restcountries.com/v3.1/lang/{lang} but API is quite unefficent:
         rq: https://restcountries.com/v3.1/lang/engl
         rs: {"status":404,"message":"Not Found"}
         It requires https://restcountries.com/v3.1/lang/english
            
         Morover the guide say "Now you can search by name in any available translation" but if i write in italian version of the language, it doesn't work:
         rq: https://restcountries.com/v3.1/lang/italiano
         rs: {"status":404,"message":"Not Found"}
         */
        let filteredCountries = self.countries.filter({ country in
            guard let name = country.name?.common?.lowercased(),
                  let region = country.region?.lowercased(),
                  let languages = country.languages else { return false }
            if name.contains(value) || region.contains(value) || languages.contains(where: { language in
                return language.value.lowercased().contains(value)
            }) {
                return true
            } else {
                return false
            }
        })
        
        self.countrySections = self.retrieveSections(filteredCountries)
    }
    
    private func fetch() {
        guard let urlString = URL(string: "https://restcountries.com/v3.1/all") else { return }
        let request = URLRequest(url: urlString)
        
        // Rest API for countries
        NetworkManager.apiRequest(request: request) { (response: [Country]) in
            self.countries = response
            self.countrySections = self.retrieveSections(response)
        } _: { error in
            self.error = error
        }
    }

    private func retrieveSections(_ countries: [Country]) -> [CountriesSection] {
        // Sort by name
        let sortedCountries = countries.sorted { lhs, rhs in
            if let lhsName = lhs.name?.common,
               let rhsName = rhs.name?.common {
                return lhsName < rhsName
            } else {
                return false
            }
        }
        
        // Create sections grouping by the first letter of the country common name
        return Dictionary(grouping: sortedCountries) { (country) -> String in
            if let value = country.name?.common?.first {
                return String(value)
            }
            return String("")
        }.sorted(by: { lhs, rhs in
            lhs.key < rhs.key
        }).map { (key: String, value: [Country]) in
            return CountriesSection(header: key, countries: value)
        }
    }
}
