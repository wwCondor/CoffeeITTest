//
//  ViewController.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DiscoverViewController: UIViewController {
    
    let sliderManager = SliderManager()
    
    var placesOfInterest: [POI] = [POI]()
    
    private let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    var locationAuthorized: Bool = false
    let regionInMeters: Double = 2500
    
    lazy var tapScreen: UIView = {
        let tapScreen = UIView()
        tapScreen.alpha = 0
        tapScreen.backgroundColor = UIColor.clear
        tapScreen.translatesAutoresizingMaskIntoConstraints = false
        tapScreen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissPreview(sender:))))
        return tapScreen
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.overrideUserInterfaceStyle = .light
        mapView.isUserInteractionEnabled = true
        mapView.isZoomEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var gradientView: GradientView = {
        let gradientView = GradientView()
        return gradientView
    }()
    
    private lazy var weatherView: WeatherView = {
        let weatherView = WeatherView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(weatherViewTapped(sender:)))
        weatherView.addGestureRecognizer(tapGesture)
        return weatherView
    }()
    
    private lazy var ibizaButton: CustomButton = {
        let ibizaButton = CustomButton(type: .custom)
        ibizaButton.addTarget(self, action: #selector(presentSlider(sender:)), for: .touchUpInside)
        return ibizaButton
    }()
    
    private lazy var listButton: CustomButton = {
        let listButton = CustomButton(type: .custom)
//        listButton.addTarget(self, action: #selector(presentPreview(sender:)), for: .touchUpInside) // For testing functionality
        listButton.addTarget(self, action: #selector(showList(sender:)), for: .touchUpInside)
        return listButton
    }()
    
    private lazy var filterButton: FilterButton = {
        let filterButton = FilterButton(type: .custom)
        filterButton.addTarget(self, action: #selector(presentSlider(sender:)), for: .touchUpInside)
        return filterButton
    }()
    
    private lazy var preview: Preview = {
        let preview = Preview()
        preview.alpha = 0
        return preview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        mapView.delegate = self
        
        getPlacesOfInterest()
        checkLocationServices()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 25
    }
    
    private func getPlacesOfInterest() {
        let connectionPossible = Reachability.checkReachable()
        if connectionPossible == true {
            print("Obtaining POI data")
            POIDataManager.getPOI { (data, error) in
                DispatchQueue.main.async {
                    guard let places = data else {
                        self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                        return
                    }
                    for place in places {
                        self.placesOfInterest.append(place)
                        self.createAnnotation(place: place)
                    }
                    print("POI data obtained")
//                    print("Places: \(self.placesOfInterest)")
                }
            }
        } else {
            presentAlert(description: NetworkingError.noReachability.localizedDescription, viewController: self)
        }
    }
    
    func getWeatherData(latitude: Double, longitude: Double) {
        print("Obtaining Weather Data")
        WeatherDataManager.getCurrentWeather(latitude: latitude, longitude: longitude) { (data, error) in
            DispatchQueue.main.async {
                guard let weather = data else {
                    self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                    return
                }
                
                self.weatherView.temperatureInfoBox.weatherIcon.image = weather.currently.iconImage
                self.weatherView.temperatureInfoBox.topLabel.text = "\(Int(weather.currently.temperature))°C"
                self.weatherView.temperatureInfoBox.bottomLabel.text = "\(weather.currently.summary)"

                self.weatherView.windInfoBox.weatherIcon.image = UIImage(named: .windDirection)
                self.weatherView.windInfoBox.topLabel.text = "\(weather.currently.windSpeed)KT"
                self.weatherView.windInfoBox.topLabel.text = "\(weather.currently.windBearing)"
                
                print("Weather data obtained")
            }
        }
    }
    
//    private func displayWeather(using viewModel: CurrentWeatherViewModel) {
//        weatherView.temperatureInfoBox.weatherIcon.image = viewModel.icon
//        weatherView.temperatureInfoBox.topLabel.text = "\(Int(viewModel.currently.temperature)/1.8)°C"
//        weatherView.temperatureInfoBox.bottomLabel.text = "\(viewModel.currently.summary)"
//
//        weatherView.windInfoBox.weatherIcon.image = UIImage(named: .windDirection)
//        weatherView.windInfoBox.topLabel.text = "\(viewModel.currently.windSpeed)KT"
//        weatherView.windInfoBox.topLabel.text = "\(viewModel.currently.windBearing)"
//    }
    
    private func createAnnotation(place: POI) {
        let annotation = MKPointAnnotation()
        annotation.title = place.name
        annotation.subtitle = place.type.name
        let coordinates = place.location.coordinates
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
        mapView.addAnnotation(annotation)
    }

    private func setupView() {
        view.backgroundColor = UIColor.blue
        
        view.addSubview(mapView)
        view.addSubview(gradientView)
        view.addSubview(weatherView)
        view.addSubview(ibizaButton)
        view.addSubview(listButton)
        view.addSubview(filterButton)
        
        view.addSubview(tapScreen)
        view.addSubview(preview)
        
        let screenHeight: CGFloat = view.frame.height
        let gradientViewHeigth: CGFloat = screenHeight/3
        
        gradientView.addGradient(from: UIColor.blue, to: UIColor.red)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), //constant: -Constant.menuBarHeight),
            
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: gradientViewHeigth),
            
            ibizaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.buttonPadding),
            ibizaButton.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: Constant.buttonPadding),
            ibizaButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constant.buttonCenterPadding),
            ibizaButton.heightAnchor.constraint(equalToConstant: Constant.smallButtonHeight),

            listButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.buttonPadding),
            listButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constant.buttonCenterPadding),
            listButton.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -Constant.buttonPadding),
            listButton.heightAnchor.constraint(equalToConstant: Constant.smallButtonHeight),
            
            weatherView.topAnchor.constraint(equalTo: ibizaButton.bottomAnchor, constant: Constant.buttonSpacing),
            weatherView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: Constant.buttonPadding),
            weatherView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -Constant.buttonPadding),
            weatherView.heightAnchor.constraint(equalToConstant: Constant.largeButtonHeight),
            
            filterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.buttonSpacing),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.buttonPadding),
            filterButton.widthAnchor.constraint(equalToConstant: Constant.menuBarHeight),
            filterButton.heightAnchor.constraint(equalToConstant: Constant.menuBarHeight),
            
            tapScreen.topAnchor.constraint(equalTo: view.topAnchor),
            tapScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tapScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tapScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            preview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.buttonSpacing),
            preview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.buttonPadding),
            preview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.buttonPadding),
            preview.heightAnchor.constraint(equalToConstant: Constant.previewHeigth),
        ])
    }
    
    func presentLocationPreview() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.tapScreen.alpha = 1
                self.preview.alpha = 1
        },
            completion: nil)
    }
    
    @objc private func presentSlider(sender: CustomButton) {
        switch sender {
        case ibizaButton:
            sliderManager.presentSlider(for: .ibiza)
        case filterButton:
            sliderManager.presentSlider(for: .filter)
        default: break
        }
    }
    
    @objc private func weatherViewTapped(sender: UIButton) {
        let islandViewController = IslandViewController()
        islandViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(islandViewController, animated: true, completion: nil)
    }
    
    @objc private func showList(sender: CustomButton) {
        print("List Button tapped")
    }
    
    @objc private func presentPreview(sender: CustomButton) {
        presentLocationPreview()
    }
    
    @objc private func dismissPreview(sender: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.tapScreen.alpha = 0
                self.preview.alpha = 0
        },
            completion: nil)
    }
    
    private func checkLocationServices() {
        print("Checking Location Servives")
        if CLLocationManager.locationServicesEnabled() {
            print("Location Services are Enabled")
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            print("Location Services are Disabled")
            presentFailedPermissionActionSheet(description: AuthorizationError.locationServicesDisabled.localizedDescription , viewController: self)
        }
    }
    
    private func checkLocationAuthorization() {
        print("Checking Location Authorization")
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            print("Requesting Authorization")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            locationAuthorized = false
            print("Authorization restricted or denied")
            presentFailedPermissionActionSheet(description: AuthorizationError.locationAuthorizationDenied.localizedDescription , viewController: self)
        case .authorizedAlways, .authorizedWhenInUse:
            locationAuthorized = true
            print("Authorized")
            mapView.showsUserLocation = true
            centerMapOnUserLocation()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        @unknown default:
            break
        }
    }
    
    private func centerMapOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension DiscoverViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationTitle = view.annotation?.title, let labelText = annotationTitle {
            print("User tapped annotation with title: \(labelText)")
            preview.titleLabel.text = "\(labelText)"
            presentLocationPreview()
        }
    }
}

extension DiscoverViewController: CLLocationManagerDelegate {
    // Informs delegate new location data is available and updates map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        getWeatherData(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
    }
    
    // Gets called when authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
