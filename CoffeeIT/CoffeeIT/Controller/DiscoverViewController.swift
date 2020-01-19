//
//  ViewController.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit
import MapKit

class DiscoverViewController: UIViewController {
    
    let sliderManager = SliderManager()
    
    var placesOfInterest: [POI] = [POI]()
    
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
        mapView.delegate = self
        return mapView
    }()
    
    private lazy var gradientView: GradientView = {
        let gradientView = GradientView()
        return gradientView
    }()
    
    private lazy var mainButton: CustomButton = {
        let mainButton = CustomButton(type: .custom)
        mainButton.addTarget(self, action: #selector(mainButtonTapped(sender:)), for: .touchUpInside)
        return mainButton
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
        getPlacesOfInterest()
    }
    
    private func getPlacesOfInterest() {
        let connectionPossible = Reachability.checkReachable()
        if connectionPossible == true {
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
//                    print("Places: \(self.placesOfInterest)")
                }
            }
        } else {
            presentAlert(description: NetworkingError.noReachability.localizedDescription, viewController: self)
        }
    }
    
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
        view.addSubview(mainButton)
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
            
            mainButton.topAnchor.constraint(equalTo: ibizaButton.bottomAnchor, constant: Constant.buttonSpacing),
            mainButton.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: Constant.buttonPadding),
            mainButton.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -Constant.buttonPadding),
            mainButton.heightAnchor.constraint(equalToConstant: Constant.largeButtonHeight),
            
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
    
    @objc private func mainButtonTapped(sender: UIButton) {
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
