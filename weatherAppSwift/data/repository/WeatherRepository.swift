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
    private let weatherApiService: WeatherApiServiceProtcol
    private let weatherResponseRepository: WeatherResponseRepositoryProtocol
    
    init (
        weatherApiService: WeatherApiServiceProtcol,
        weatherResponseRepository: WeatherResponseRepositoryProtocol
    ) {
        self.weatherApiService = weatherApiService
        self.weatherResponseRepository = weatherResponseRepository
    }
    
    // APIを実行し、結果をJSONパースして受け取る
    func fetchWeatherData(city: String) async throws -> WeatherApiResponseModel {
        let weatherApiService = WeatherApiService()
        let repository = WeatherResponseRepository()
    
        let jsonData = try await weatherApiService.fetchWeather(city: city)
        let decodedData = try repository.wetherApiResponseDecoding(from: jsonData)
        return decodedData
        
    }
}
