//
//  WeatherAPIRepository.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/15.
//

import SwiftUI


/**
 天気情報取得API（プロトコル）
 */
protocol WeatherApiServiceProtcol {
    // 天気情報取得APIを実行
    func fetchWeather(city: String) async throws -> Data
}

/**
 天気情報取得API
 */
class WeatherApiService: WeatherApiServiceProtcol {
    
    // 天気情報取得APIを実行
    func fetchWeather(city: String) async throws -> Data {
        // API実行URLを設定
        let BaseUrl = Bundle.main.object(forInfoDictionaryKey: "ENV_API_ENDPOINT") as? String
        
        // API実行URLが異常な場合
        if BaseUrl == nil || BaseUrl == "" {
            throw URLError(.badURL)
        }
        
        // URL形式ではなかった場合
        guard let BaseUrlString = BaseUrl, let url = URL(string: BaseUrlString + city) else {
            throw URLError(.badURL)
        }
        
        // API実行（URLセッション）
        let (data, response) = try await URLSession.shared.data(from: url)
        
        //レスポンスチェック
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
