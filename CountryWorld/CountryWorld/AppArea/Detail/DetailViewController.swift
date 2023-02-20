//
//  DetailViewController.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 17/02/23.
//

import UIKit
import Combine
import MapKit

class DetailViewController: BaseViewController {
    
    @IBOutlet weak private var flagImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var officalNameLabel: UILabel!
    @IBOutlet weak private var regionLabel: UILabel!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var itemsStackView: UIStackView!
    @IBOutlet weak private var mapView: MKMapView!
    
    var viewModel: DetailViewModel!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubscriptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureSubscriptions() {
        self.viewModel.$country.filter({ $0 != nil }).sink { value in
            self.configureDetail(with: value!)
        }.store(in: &subscriptions)
        
        self.viewModel.$items.filter({ $0 != nil }).sink { value in
            self.configureItems(with: value!)
        }.store(in: &subscriptions)
    }
    
    private func configureDetail(with country: Country) {
        self.flagImageView.setImageFromStringrURL(stringUrl: country.flags?.png)
        
        self.nameLabel.text = country.name?.common
        self.officalNameLabel.text = country.name?.official
        self.regionLabel.text = country.region
        self.configureMap(country)
    }
    
    private func configureItems(with items: [DetailItem]) {
        self.itemsStackView.subviews.forEach({ $0.removeFromSuperview() })
        items.forEach { item in
            let detailItemView = DetailItemView()
            detailItemView.image = item.image
            detailItemView.title = item.title
            detailItemView.value = item.value
            self.itemsStackView.addArrangedSubview(detailItemView)
        }
    }
    
    private func configureMap(_ country: Country) {
        let annotation = MKPointAnnotation()
        
        guard let pLat = country.latlng?.first,
              let pLong = country.latlng?[1] else {
            self.mapView.isHidden = true
            return
        }

        annotation.coordinate =  CLLocationCoordinate2D(latitude: pLat, longitude: pLong)

        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))
    
        self.mapView.isUserInteractionEnabled = false

        mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(annotation)
    }
}
