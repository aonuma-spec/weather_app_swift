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
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "ENV_API_ENDPOINT") as? String,
              !baseUrl.isEmpty,
              // URL形式のオブジェクトを設定
              var urlComponents = URLComponents(string: baseUrl)
        else {
            throw URLError(.badURL)
        }

        // APIキーを取得
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String,
                !apiKey.isEmpty
        else {
            throw URLError(.badURL)
        }

        // パラメータを設定（q = 地域名）
        var queries : [String: String] = [
            "appid": apiKey,
            "lang": "ja",
            "units":"metric",
            "q" : city,
        ]
        
        urlComponents.queryItems =
            queries.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }

        // URLを取得
        guard let url = urlComponents.url else {
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
