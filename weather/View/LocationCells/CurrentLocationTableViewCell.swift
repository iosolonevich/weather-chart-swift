//
//  CurrentLocationTableViewCell.swift
//  weather
//
//  Created by alex on 20.05.2021.
//

import UIKit

class CurrentLocationTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        label.text = "Current location"
        return label
    }()
    
    let currentLocationSwitch: UISwitch = {
        let uiswitch = UISwitch()
        
        uiswitch.isEnabled = false
        
        // add primary action
        return uiswitch
    }()
    
    func setLayout() {
        self.contentView.addSubview(locationLabel, anchors: [
                .centerY(self.contentView.centerYAnchor),
                .leading(self.contentView.leadingAnchor, 20) ])
        self.contentView.addSubview(currentLocationSwitch, anchors: [
                .centerY(self.contentView.centerYAnchor),
                .trailing(self.contentView.trailingAnchor, -15)])
    }

}
