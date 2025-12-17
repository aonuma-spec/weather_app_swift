//
//  WeatherDetailPresenter.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/17.
//

import Foundation


func setWeatherImageString(weather: String) -> String {
        var weatherImage: String = "mark_tenki_hare"
        switch weather {
            case "Clear":
                weatherImage = "mark_tenki_hare"
            case "Clouds":
                weatherImage = "mark_tenki_kumori"
            case "Rain":
                weatherImage = "mark_tenki_umbrella"
            case "Snow":
                weatherImage = "tenki_snow"
            default:
                weatherImage = "mark_question"
        }
    return weatherImage
}

/**
 地域の気温差を計算する
 */
func calcTempDiff(temp: Double, targetTemp: Double) -> String {
    let diff = abs(temp - targetTemp)
    return doubleToString(source: diff)
}

func doubleToString(source: Double) -> String {
    return String(format: "%.2f", source)
}
