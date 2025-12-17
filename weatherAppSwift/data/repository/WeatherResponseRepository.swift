//
//  WeatherResponseRepository.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/16.
//

import SwiftUI

/**
 天気情報取得APIの実行結果レスポンス（プロトコル）
 return: 正常時はWeatherApiResponseModel型のデータ、エラー時はthrowsを返却
 */
protocol WeatherResponseRepositoryProtocol {
    // 天気情報取得APIのJSONデータをパースする関数
    func wetherApiResponseDecoding(from jsonData: Data) throws -> WeatherApiResponseModel
}

/**
 天気情報取得APIの実行結果レスポンス
 return: 正常時はWeatherApiResponseModel型のデータ、エラー時はthrowsを返却
 */
struct WeatherResponseRepository {
    // 天気情報取得APIのJSONデータをパースする関数
    func wetherApiResponseDecoding(from jsonData: Data) throws -> WeatherApiResponseModel {
        return try JSONDecoder().decode(WeatherApiResponseModel.self, from: jsonData)
    }
}
