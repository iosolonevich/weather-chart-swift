//
//  WeatherScreenCVDelegate.swift
//  weather
//
//  Created by alex on 05.05.2021.
//

import UIKit

class WeatherScreenCVDelegateController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var dataSource: WeatherViewModel?
    var location: Location?
    
    init(dataSource: WeatherViewModel?, location: Location) {
        self.dataSource = dataSource
        self.location = location
    }
    
    convenience init(location: Location) {
        self.init(dataSource: nil, location: location)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeatherHeaderCell.reuseIdentifier, for: indexPath) as? WeatherHeaderCell {
                headerView.backgroundColor = .lightGray
                headerView.locationNameLabel.text = location?.locationName
                headerView.temperatureLabel.text = dataSource?.currentTemperature
                
                return headerView
            }
        } else {
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeatherFooterCell.reuseIdentifier, for: indexPath) as? WeatherFooterCell {
                footerView.backgroundColor = .lightGray
                footerView.locationNameTextView.text = "footer"
                
                return footerView
            }
        }
        
        fatalError(debugDescription)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDailyForecastCell.reuseIdentifier, for: indexPath) as? WeatherDailyForecastCell {
//                cell.locationNameTextView.text = String(dataSource.current.temp - 273.15)
                
                cell.lineChart.dataEntries = dataSource?.dailyDataEntries
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDailyForecastCell.reuseIdentifier, for: indexPath) as? WeatherDailyForecastCell {
                cell.locationNameTextView.text = "forecast 2"
                cell.backgroundColor = .systemGreen
                
                return cell
            }
        }
        fatalError(debugDescription)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 30, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 80)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == collectionView.numberOfSections - 1 {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return .zero
        }
    }
}
