//
//  WeatherDetailModel.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/17.
//

import Foundation

struct WeatherDetailModel {
    let CityName: String
    let weatherMain: String
    let description: String
    let currentTemp: Double
    let humidity: Int
    let minPlaceName: String
    let minTemp: Double
    let minTempDiff: Double
    let maxPlaceName: String
    let maxTemp: Double
    let maxTempDiff: Double
}
