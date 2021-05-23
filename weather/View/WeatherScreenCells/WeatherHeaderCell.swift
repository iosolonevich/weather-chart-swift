//
//  WeatherHeaderCell.swift
//  weather
//
//  Created by alex on 05.05.2021.
//

import UIKit

class WeatherHeaderCell: UICollectionViewCell {
    
    static let reuseIdentifier = "weather-header-reusable-view"
    
    let locationNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.lightGray
        label.textAlignment = .center
        
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(locationNameLabel, anchors: [ .leading(leadingAnchor), .top(topAnchor), .widthConstant(100), .bottom(bottomAnchor) ])
        
        addSubview(temperatureLabel, anchors: [ .trailing(trailingAnchor), .top(topAnchor), .widthConstant(50), .bottom(bottomAnchor) ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
