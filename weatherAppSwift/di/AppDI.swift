//
//  AppDI.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/16.
//

import Foundation

struct AppDI {
    static func makePresenter() -> MainPresenter {
        let apiService = WeatherApiService()
        let repository = WeatherRepository(weatherApiService: apiService)
        return MainPresenter(weatherRepository: repository)
    }
}
