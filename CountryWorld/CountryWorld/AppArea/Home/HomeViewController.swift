//
//  HomeViewController.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 17/02/23.
//

import UIKit
import Combine
import SkeletonView

class HomeViewController: BaseViewController {

    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var countriesTableView: UITableView!

    var viewModel: HomeViewModel!
    
    private var selectedIndexPath: IndexPath?
    
    private var sections: [CountriesSection] = [] {
        didSet {
            // hide skeleton on tableview must be called on the main thread
            DispatchQueue.main.async {
                self.countriesTableView.hideSkeleton()
                self.countriesTableView.reloadData()
            }
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureComponents()
        self.configureNavigationItem()
        self.view.showAnimatedSkeleton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureSubscriptions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // unsubscribe subscriptions
        self.subscriptions.forEach({ $0.cancel() })
    }

    private func configureComponents() {

        self.view.isSkeletonable = true

        self.searchBar.delegate = self
        self.searchBar.placeholder = String(localized: "searchbar_placeholder")
        self.searchBar.returnKeyType = .done
        
        self.countriesTableView.sectionHeaderTopPadding = 0
        self.countriesTableView.delegate = self
        self.countriesTableView.dataSource = self
        self.countriesTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "countryCell")
        self.countriesTableView.rowHeight = UITableView.automaticDimension
        self.countriesTableView.estimatedRowHeight = 60
    }
    
    private func configureNavigationItem() {
        let headerView = HeaderView()
        headerView.title = String(localized: "header_title")
        self.navigationItem.titleView = headerView
    }
    
    private func configureSubscriptions() {
        self.viewModel.$countrySections
            .filter({ $0 != nil })
            .sink { sections in
                self.sections = sections!
            }.store(in: &subscriptions)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterCountries(value: searchText.lowercased())
        self.countriesTableView.startSkeletonAnimation()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension HomeViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].countries.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "countryCell"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        
        let model = self.sections[indexPath.section].countries[indexPath.row]
        
        cell.countryName = model.name?.common
        cell.countryImageUrl = model.flags?.png
        cell.continentName = model.region

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CountryTableViewCell {
            cell.countryNameLabel.font = CountryTableViewCell.appearance().themeTitleFont
            cell.countryNameLabel.textColor = CountryTableViewCell.appearance().themeTitleColor
            cell.continentNameLabel.font = CountryTableViewCell.appearance().themeSubtitleFont
            cell.continentNameLabel.textColor = CountryTableViewCell.appearance().themeSubtitleColor
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = skeletonView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        
        guard self.sections.count > 0 else { return cell }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CountrySectionHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let header = self.sections[section].header
        view.title = String(header)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = self.sections[indexPath.section].countries[indexPath.row]
        self.selectedIndexPath = indexPath
        self.viewModel.openDetail(country: country)
    }
}
