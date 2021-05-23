//
//  WeaherFooterCell.swift
//  weather
//
//  Created by alex on 05.05.2021.
//

import UIKit

class WeatherFooterCell: UICollectionViewCell {
    
    static let reuseIdentifier = "weather-footer-reusable-view"
    
    var locationNameTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        
        textView.backgroundColor = UIColor.brown
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(locationNameTextView, anchors: [ .centerX(centerXAnchor), .top(topAnchor, frame.height * 0.18), .width(widthAnchor), .heightConstant(80) ])

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
