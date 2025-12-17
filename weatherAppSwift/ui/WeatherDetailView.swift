//
//  WeatherDetailView.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/15.
//

import SwiftUI

struct WeatherDetailView: View {
    
    let weatherDetail: WeatherDetailModel
    
    var body: some View {
        NavigationStack {
            VStack {
            // 地域名
                cityNameTitle
                    .padding(.top, 18)
            // 地域画像
                weatherImage
                    .padding(.top, 18)
            // 天気情報詳細
                weatherData
                    .padding(.top, 18)
            // 各地との気温差
                tempDiffAreas
                    .padding(.top, 36)
            }
            // アプリタイトル
            .navigationTitle("天気詳細")
            .toolbarBackground(
                Color(red: 0x38/255.0,
                      green: 0x58/255.0,
                      blue: 0x51/255.0),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }

    }

    /**
     地域名
     */
    @ViewBuilder private var cityNameTitle: some View {
        Text(weatherDetail.CityName)
            .font(.title2)
            .frame(maxWidth: 300)
            .foregroundStyle(Color.white)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            .background(
                Color(red: 0x38/255.0,
                      green: 0x58/255.0,
                      blue: 0x51/255.0)
                )
    }

    /**
     地域画像
     */
    
    @ViewBuilder private var weatherImage: some View {
        
        Image(setWeatherImageString(weather: weatherDetail.weatherMain))
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 200)
    }

    /**
     天気情報詳細
     */
    @ViewBuilder private var weatherData: some View {
        VStack {
            weatherDataRow(subTitle: "天気", weatherData: weatherDetail.description)
            weatherDataRow(subTitle: "温度", weatherData: "\(weatherDetail.currentTemp) 度")
            weatherDataRow(subTitle: "湿度", weatherData: "\(weatherDetail.humidity) %")
        }
    }

    @ViewBuilder private var tempDiffAreas: some View {
        VStack {
            Text("\(weatherDetail.CityName)と各地の気温差について")
                .font(.title2)
            List {
                Text(
                    "日本で平均気温が低い「陸別（現在6.5度）」より7.07度暖かいです"
                )
                Text(
                    "日本で平均気温が低い「陸別（現在6.5度）」より7.07度暖かいです"
                )
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
        }
    }

    /**
     天気情報詳細のテンプレート
     */
    struct weatherDataRow: View {
        let subTitle: String
        let weatherData: String

        var body: some View {
            HStack {
                Text("\(subTitle)")
                    .foregroundStyle(Color.white)
                    .frame(width: 50)
                    .padding(10)
                    .background(
                        Color(
                            red: 0x38/255.0,
                            green: 0x58/255.0,
                            blue: 0x51/255.0
                        )
                    )
                Text("\(weatherData)")
                    .frame(
                        width: 250,
                        alignment: .leading
                    )
                    .padding(.leading, 16)
            }
        }
    }
}

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

#Preview {
    WeatherDetailView(weatherDetail: .preview)
}
