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
            await fetchWeather(selectedCity: selectedCity)
        }
        
        // 次の画面に移動
    }
    
    /**
     エラーの表示
     */
    func showError(_ error: Error) {
        hasError = true
        errorMessage = error.localizedDescription
    }
    
    /**
     非同期でAPIの実行
     */
    private func fetchWeather(selectedCity: String) async {
        do {
            
            //APIを非同期で実行
            let response = try await weatherRepository.fetchWeatherData(city: selectedCity)
            
            //APIレスポンスを天気詳細画面用のモデルに変換
            let detail = WeatherDetailModel(
                CityName: response.name,
                weatherMain: response.weather.first?.main ?? "",
                description: response.weather.first?.description ?? "",
                currentTemp: response.main.temp,
                humidity: response.main.humidity,
                minPlaceName: "最低気温",
                minTemp: response.main.temp_min ?? 0,
                minTempDiff: 0,
                maxPlaceName: "最高気温",
                maxTemp: response.main.temp_max ?? 0,
                maxTempDiff: 0
            )
            
            self.weatherDetail = detail
            
        } catch {
            showError(error)
        }
    }
}

