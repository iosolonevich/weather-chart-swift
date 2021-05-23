//
//  Location.swift
//  weather
//
//  Created by alex on 17.05.2021.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        label.numberOfLines = 1
        
        return label
    }()
    
    var location: Location? {
        didSet {
            guard let locationItem = location else { return }
            locationLabel.text = locationItem.locationName
            
        }
    }
    
    func setLayout() {
        contentView.addSubview(locationLabel, anchors: [ .centerY(centerYAnchor), .leading(leadingAnchor, 60), .width(widthAnchor, 1, -100) ])
    }
}
