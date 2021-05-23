//
//  WeatherDailyForecastCell.swift
//  weather
//
//  Created by alex on 05.05.2021.
//

import UIKit

class WeatherDailyForecastCell: UICollectionViewCell {
    
    static let reuseIdentifier = "weather-dailyforecast-cell"
    
    let locationNameTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        
        textView.backgroundColor = UIColor.white
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        
        return textView
    }()
    
    let lineChart: LineChart = {
        let lineChart = LineChart()
        return lineChart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lineChart.backgroundColor = .white
        addSubview(lineChart, anchors: [ .top(topAnchor), .leading(leadingAnchor), .trailing(trailingAnchor), .bottom(bottomAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
