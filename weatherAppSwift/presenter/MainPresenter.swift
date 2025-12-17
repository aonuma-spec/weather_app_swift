//
//  MainPresenter.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/16.
//

import SwiftUI

@MainActor
struct MainPresenter{
    struct Presenter :MainContract.Presenter {
        
        private let weatherRepository: WeatherRepositoryProtocol
        
        init(weatherRepository: WeatherRepositoryProtocol) {
            self.weatherRepository = weatherRepository
        }
        /**
         地域送信ボタンを押下した時に実行される関数
         */
        func onCitySubmitButtonClicked(selectedCity: String) {
            // 非同期でAPIの実行
            fetchWeather(selectedCity: selectedCity)
            
            // 次の画面に移動
        }
        
        /**
         非同期でAPIの実行
         */
        private func fetchWeather(selectedCity: String) {
            Task {
                
                do {
                    let result = try await weatherRepository.fetchWeatherData(city: selectedCity)
                    print(result)
                } catch let error as URLError {
                    switch error.code {
                    case .badURL:
                        print("URLが不正です")
                    case .badServerResponse:
                        print("サーバーエラーです")
                    case .notConnectedToInternet:
                        print("インターネットに接続されていません")
                    default:
                        print("通信エラー: \(error)")
                    }
                } catch {
                    print("エラー: \(error)")
                }
                
            }
            // エラーの判定
        }
        
        
    }
}

