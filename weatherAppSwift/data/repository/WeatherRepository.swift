//
//  WeatherRepository.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/16.
//

/**
 Presenterから呼び出されるAPI実行関数（プロトコル）
 */
protocol WeatherRepositoryProtocol {
    // APIを実行し、結果をJSONパースして受け取る
    func fetchWeatherData(city: String) async throws -> WeatherApiResponseModel
}

/**
 Presenterから呼び出されるAPI実行関数
 */
struct WeatherRepository: WeatherRepositoryProtocol {

    private let weatherApiService: WeatherApiServiceProtocol
    private let weatherResponseRepository: WeatherResponseRepositoryProtocol

    init(
        weatherApiService: WeatherApiServiceProtocol,
        weatherResponseRepository: WeatherResponseRepositoryProtocol = WeatherResponseRepository()
    ) {
        self.weatherApiService = weatherApiService
        self.weatherResponseRepository = weatherResponseRepository
    }
    
    // APIを実行し、結果をJSONパースして受け取る
    func fetchWeatherData(city: String) async throws -> WeatherApiResponseModel {
        let jsonData = try await weatherApiService.fetchWeather(city: city)
        let decodedData = try weatherResponseRepository
            .wetherApiResponseDecoding(from: jsonData)
        return decodedData
    }
}
