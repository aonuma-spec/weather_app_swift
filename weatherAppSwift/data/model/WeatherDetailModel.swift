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
}

extension WeatherDetailModel {
    static let preview = WeatherDetailModel(
        CityName: "東京",
        weatherMain: "晴れ",
        description: "快晴",
        currentTemp: 12.3,
        humidity: 50,
    )
}
