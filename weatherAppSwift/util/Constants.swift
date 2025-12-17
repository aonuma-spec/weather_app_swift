//
//  Constants.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/15.
//

import SwiftUI

struct Constants{
    static let CITY_MODELS: [CityModel] = [
        CityModel(cityName: "東京", cityValue: "tokyo"),
        CityModel(cityName: "札幌", cityValue: "sapporo"),
        CityModel(cityName: "仙台", cityValue: "sendai"),
        CityModel(cityName: "新潟", cityValue: "niigata"),
        CityModel(cityName: "栃木", cityValue: "tochigi"),
        CityModel(cityName: "大阪", cityValue: "osaka"),
        CityModel(cityName: "鹿児島", cityValue: "kagoshima"),
        CityModel(cityName: "沖縄", cityValue: "okinawa"),
    ]
    
    static let MIN_TEMP_CITY = "rikubetsu"
    static let MAX_TEMP_CITY = "okinawa"
}
