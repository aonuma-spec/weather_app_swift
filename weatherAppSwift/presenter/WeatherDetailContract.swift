//
//  WeatherDetailContract.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/17.
//

import Foundation

struct WeatherDetailContract {
    
    protocol Presenter {

        /**
         APIのデータから天気情報を表示画像名に変換して渡す
         */
        func setWeatherImageString(weather: String) -> String
        
        /**
         地域の気温差を計算する
         */
        func calcTempDiff(temp: Double, targetTemp: Double) -> String
    }
}
