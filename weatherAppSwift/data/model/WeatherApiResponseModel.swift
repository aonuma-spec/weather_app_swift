//
//  WeatherApiResponseModel.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/16.
//

import Foundation

/**
 天気情報取得APIのレスポンスへJSONパースする構造体
 */
struct WeatherApiResponseModel: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    
    struct Weather: Decodable {
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let humidity: Int
        let temp_min: Double?
        let temp_max: Double?
    }
}

