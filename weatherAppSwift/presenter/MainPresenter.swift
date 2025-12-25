//
//  MainPresenter.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/16.
//

import SwiftUI
import Combine

@MainActor
final class MainPresenter: ObservableObject, MainContract.Presenter {
    @Published var selectedCityWeather: WeatherDetailModel? = nil
    @Published var minTempCityWeather: WeatherDetailModel? = nil
    @Published var maxTempCityWeather: WeatherDetailModel? = nil
    @Published var weatherDetail: WeatherDetailModel? = nil
    @Published var hasError: Bool = false
    @Published var errorMessage: String? = nil
    
    private let weatherRepository: WeatherRepositoryProtocol
    
    init(weatherRepository: WeatherRepositoryProtocol) {
        self.weatherRepository = weatherRepository
    }
    /**
     地域送信ボタンを押下した時に実行される関数
     */
    func onCitySubmitButtonClicked(selectedCity: String) {
        // 非同期でAPIの実行
        Task {
            async let detailTask = self.fetchWeather(selectedCity: selectedCity)
            async let minTempCityWeather = self.fetchWeather(selectedCity: Constants.MIN_TEMP_CITY)
             async let maxTempCityWeather = self.fetchWeather(selectedCity: Constants.MAX_TEMP_CITY)
            
            self.weatherDetail = await detailTask
            self.minTempCityWeather = await minTempCityWeather
            self.maxTempCityWeather = await maxTempCityWeather
        }
        
    }
    
    /**
     エラーの表示
     */
    func showError(_ error: Error) {
        print("エラー発生: \(error)") // <- デバッグ用
        hasError = true
        errorMessage = "エラーが発生しました"
    }
    
    /**
     非同期でAPIの実行
     */
    func fetchWeather(selectedCity: String) async -> WeatherDetailModel? {
        do {
            //APIを非同期で実行
            let response = try await weatherRepository.fetchWeatherData(city: selectedCity)
            
            //APIレスポンスを天気詳細画面用のモデルに変換
            let detail = WeatherDetailModel(
                cityName: response.name,
                weatherMain: response.weather.first?.main ?? "",
                description: response.weather.first?.description ?? "",
                currentTemp: response.main.temp,
                humidity: response.main.humidity,
            )
            
//            self.weatherDetail = detail
            return detail
            
        } catch {
            showError(error)
            return nil
        }
    }
}

