//
//  CoffeeITTests.swift
//  CoffeeITTests
//
//  Created by Wouter Willebrands on 15/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import XCTest
@testable import CoffeeIT

class CoffeeITTests: XCTestCase {
    
    var session: URLSession!

    override func setUp() {
        super.setUp()
        session = URLSession(configuration: .default)
    }

    override func tearDown() {
        session = nil
        super.tearDown()
    }
    
    // Test API call 
    func testPOIDataManager() {
        let expectation = self.expectation(description: "allPlaces.count =! 0")
        var responseError: Error?
        var allPlaces: [POI]?
        POIDataManager.getPOI { (data, error) in
            guard let places = data else {
                responseError = error
                return
            }
            allPlaces = places
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError, "Error")
        XCTAssertNotNil(allPlaces)
    }
    
    func testWeatherDataManager() {
        let expectation = self.expectation(description: "weather =! nil")
        var responseError: Error?
        var weatherData: Weather?
        let coordinate: [Double] = [52.09083, 5.12222]
        WeatherDataManager.getCurrentWeather(latitude: coordinate[0], longitude: coordinate[1], completion: { (data, error) in
            guard let weather = data else {
                responseError = error
                return
            }
            weatherData = weather
            expectation.fulfill()
        })

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError, "Error")
        XCTAssertNotNil(weatherData)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
