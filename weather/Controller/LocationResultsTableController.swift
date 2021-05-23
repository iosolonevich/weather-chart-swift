//
//  LocationResultsTableControllerTableViewController.swift
//  weather
//
//  Created by alex on 17.05.2021.
//

import UIKit
import MapKit

class LocationResultsTableController: UITableViewController {

    var searchResults = [MKLocalSearchCompletion]()
    var searchCompleter = MKLocalSearchCompleter()
    
    var onSearchDoneBlock: ((Bool) -> Void)?
    
    private var locationManager: LocationManager
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        searchCompleter.delegate = self
        searchCompleter.pointOfInterestFilter = .none
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        onDoneBlock!(true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchResults[indexPath.row].title

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else { return }
            guard let name = response?.mapItems[0].name else { return }

            if !self.locationManager.getLocations().contains(where: { $0.locationName == name }) {
                self.locationManager.saveLocation(Location(locationName: name, locationOWMId: 0, id: self.locationManager.getDefaultOrder(), latitude: coordinate.latitude, longitude: coordinate.longitude))
            }
            self.onSearchDoneBlock!(true)
        }

        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
        
    }

}

extension LocationResultsTableController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results.filter { result in
            if result.title.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                return false
            }

            if result.subtitle.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                return false
            }

            return true
        }

        self.tableView.reloadData()
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
