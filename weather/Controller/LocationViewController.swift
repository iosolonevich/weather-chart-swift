//
//  LocactionViewController.swift
//  weather
//
//  Created by alex on 17.05.2021.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    var searchController: UISearchController?
    var locationResultsController: LocationResultsTableController
    
    var onLocationReorderingDoneBlock: ((Bool) -> Void)?
    
    private var locationManager: LocationManager
//    private var locations: [Location]?
    
    let locationsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor.white
        
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "locationCell")
        tableView.register(CurrentLocationTableViewCell.self, forCellReuseIdentifier: "currentlocationcell")
        
        return tableView
    }()
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
//        locations = locationManager.getLocations()
        locationResultsController = LocationResultsTableController(locationManager: locationManager)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Locations"
        
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        
        locationsTableView.isEditing = true

        locationResultsController.onSearchDoneBlock = { result in
            if result {
                self.reset()
            }
        }
        
        searchController = UISearchController(searchResultsController: locationResultsController)
//         monitor when the search controller is presented and dismissed
//        searchController?.delegate = self
//         monitor when the search button is tapped, and start/end editing
        searchController?.searchBar.delegate = self
        
        searchController?.searchBar.returnKeyType = .search
        searchController?.searchBar.searchTextField.placeholder = NSLocalizedString("Enter a location", comment: "")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        definesPresentationContext = true
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .always
    }
  
    func setupViews() {
        view.addSubview(locationsTableView, anchors: [ .top(view.topAnchor), .leading(view.leadingAnchor), .trailing(view.trailingAnchor), .bottom(view.bottomAnchor) ])
    }
    
    func reset() {
        self.searchController?.searchBar.text = ""
//        self.locations = self.locationManager.getLocations()
        self.locationsTableView.reloadData()
    }
}

extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationManager.getLocations().count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 * 1.3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentlocationcell", for: indexPath) as? CurrentLocationTableViewCell
            if let cell = cell {
                cell.selectionStyle = .none
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell
            let locations = locationManager.getLocations()
            if let cell = cell {
                cell.location = locations[indexPath.row - 1]
                cell.selectionStyle = .none
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationManager.deleteLocation(locationManager.getLocations()[indexPath.row - 1])
        }
        reset()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        locationManager.reorderLocations(moveRowAt: sourceIndexPath.row - 1, to: destinationIndexPath.row - 1)
        onLocationReorderingDoneBlock!(true)
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == 0 {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
}

extension LocationViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        locationResultsController.searchCompleter.queryFragment = searchText
    }
}
