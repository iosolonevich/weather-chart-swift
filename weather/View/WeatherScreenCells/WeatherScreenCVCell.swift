//
//  WeatherCVCell.swift
//  weather
//
//  Created by alex on 05.05.2021.
//

import UIKit

class WeatherScreenCVCell: UICollectionViewCell {
    
//    var textLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        return label
//    }()
    
    private lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
//        textLabel.text = "qwe"
//        contentView.addSubview(textLabel, anchors: [ .centerX(centerXAnchor), .centerY(centerYAnchor) ])
        
        weatherCollectionView.register(WeatherHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeatherHeaderCell.reuseIdentifier)
        weatherCollectionView.register(WeatherFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: WeatherFooterCell.reuseIdentifier)
        weatherCollectionView.register(WeatherDailyForecastCell.self, forCellWithReuseIdentifier: WeatherDailyForecastCell.reuseIdentifier)
        
        contentView.addSubview(weatherCollectionView, anchors: [ .top(contentView.topAnchor), .bottom(contentView.bottomAnchor), .leading(contentView.leadingAnchor), .trailing(contentView.trailingAnchor) ])
        
        contentView.addSubview(weatherCollectionView)
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        weatherCollectionView.delegate = dataSourceDelegate
        weatherCollectionView.dataSource = dataSourceDelegate
        
        weatherCollectionView.reloadData()
    }
}
