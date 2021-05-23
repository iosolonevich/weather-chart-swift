//
//  MainCVController.swift
//  weather
//
//  Created by alex on 04.05.2021.
//

import UIKit


class WeatherCVController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    static let reuseIdentifier = "WeatherScreen"
    
    private var urlSessionProvider: ProviderProtocol
    private var locationManager: LocationManager
    
    private var weatherScreenCVDelegateControllers: [WeatherScreenCVDelegateController]
    
    let locationVC: LocationViewController?

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.addTarget(self, action: #selector(pageControlTapped(sender:)), for: .valueChanged)
        return pageControl
    }()
    
    init(collectionViewLayout layout: UICollectionViewLayout, urlSessionProvider provider: ProviderProtocol, locationManager: LocationManager) {
        self.urlSessionProvider = provider
        self.locationManager = locationManager
        self.weatherScreenCVDelegateControllers = []
        for location in locationManager.getLocations() {
            self.weatherScreenCVDelegateControllers.append(WeatherScreenCVDelegateController(location: location))
        }

        self.locationVC = LocationViewController(locationManager: locationManager)
        
        super.init(collectionViewLayout: layout)
        
        //fetchWeather()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainCollectionView()
        transparentNavigationBar()
        
        locationVC?.onLocationReorderingDoneBlock = { result in
            if result {
                
                let locations = self.locationManager.getLocations()
                for weatherScreenCVDelegateController in self.weatherScreenCVDelegateControllers {
                    if let currentLocation = locations.first(where: { $0 == weatherScreenCVDelegateController.location }) {
                        weatherScreenCVDelegateController.location?.id = currentLocation.id
                    }
                }
                
                self.weatherScreenCVDelegateControllers = self.weatherScreenCVDelegateControllers.sorted(by: { (delegate1, delegate2) -> Bool in
                    return delegate1.location!.id < delegate2.location!.id
                })
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchWeather()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        fetchWeather()
//    }
    
    func setupMainCollectionView() {
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(WeatherScreenCVCell.self, forCellWithReuseIdentifier: WeatherCVController.reuseIdentifier)
        
        let locationsCount = locationManager.getLocations().count
        pageControl.numberOfPages = locationsCount
        pageControl.isHidden = locationsCount == 0 || locationsCount == 1
        view.addSubview(pageControl, anchors: [ .centerX(view.centerXAnchor), .bottom(view.bottomAnchor, -20) ])
        
        let manageLocationButton = UIBarButtonItem(image: UIImage(systemName: "plus.magnifyingglass"), style: .done, target: self, action: #selector(handleAddLocationButton))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: nil)
        
        manageLocationButton.tintColor = UIColor.black
        settingsButton.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItem = manageLocationButton
        navigationItem.leftBarButtonItem = settingsButton
                
    }
    
    func fetchWeather() {
        for location in locationManager.getLocations() {
            urlSessionProvider.request(type: WeatherModel.self, service: ForecastProvider.oneCall(lat: location.latitude, lon: location.longitude, exclude: nil)) { [weak self] response in
                switch response {
                case let .success(forecast):
                    if let self = self {
                        self.weatherScreenCVDelegateControllers.first(where: { $0.location == location })?.dataSource = WeatherViewModel(weatherModel: forecast)
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    private func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func handleAddLocationButton() {
//        let locationVC = LocationViewController(locationManager: locationManager)
        guard let locationVC = locationVC else { return }
        let navController = UINavigationController(rootViewController: locationVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        let pageWidth = collectionView.bounds.width
        let offset = sender.currentPage * Int(pageWidth)
        
        UIView.animate(withDuration: 0.33) { [weak self] in
            self?.collectionView.contentOffset.x = CGFloat(offset)
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationManager.getLocations().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let collectionViewCell = cell as? WeatherScreenCVCell {
            collectionViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: weatherScreenCVDelegateControllers[indexPath.row])
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCVController.reuseIdentifier, for: indexPath) as! WeatherScreenCVCell

        
        return cell
    }

    // MARK: UICollectionViewDelegate

    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
