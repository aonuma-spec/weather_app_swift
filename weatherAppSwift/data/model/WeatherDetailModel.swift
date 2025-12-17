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

extension WeatherDetailModel {
    static let preview = WeatherDetailModel(
        CityName: "東京",
        weatherMain: "晴れ",
        description: "快晴",
        currentTemp: 12.3,
        humidity: 50,
        minPlaceName: "最低気温",
        minTemp: 8.0,
        minTempDiff: -2.0,
        maxPlaceName: "最高気温",
        maxTemp: 15.0,
        maxTempDiff: 3.0
    )
}
