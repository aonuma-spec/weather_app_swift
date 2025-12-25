//
//  WeatherDetailView.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/15.
//

import SwiftUI

struct WeatherDetailView: View {
    // 画面のPortlate, landScapeの設定用
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    let weatherDetail: WeatherDetailModel
    let minTempCityWeather: WeatherDetailModel?
    let maxTempCityWeather: WeatherDetailModel?
    
    var body: some View {
        NavigationStack {
            Group {
                if verticalSizeClass == .compact {
                    // 横向き
                    HStack {
                        VStack {
                            // 地域名
                            cityNameTitle
                                .padding(.top, 18)
                            // 天気画像
                            weatherImage(landScape: true)
                            // 天気情報詳細
                            weatherData
                                .padding(.leading, 18)
                        }
                        // 各地との気温差
                        tempDiffAreas
                            .padding(.top, 36)
                    }
                } else {
                    // 縦向き
                    VStack {
                        // 地域名
                        cityNameTitle
                            .padding(.top, 18)
                        // 地域画像
                        weatherImage(landScape: false)
                        // 天気情報詳細
                        weatherData
                            .padding(.top, 18)
                        // 各地との気温差
                        tempDiffAreas
                            .padding(.top, 18)
                    }
                }
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
        Text(weatherDetail.cityName)
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
    @ViewBuilder
    private func weatherImage(landScape: Bool) -> some View {
        
        let size: CGFloat = landScape ? 100 : 200
        Image(setWeatherImageString(weather: weatherDetail.weatherMain))
            .resizable()
            .scaledToFit()
            .frame(maxWidth: size)
    }

    /**
     天気情報詳細
     */
    @ViewBuilder private var weatherData: some View {
        VStack {
            weatherDataRow(
                subTitle: "天気",
                weatherData: weatherDetail.description
            )
            weatherDataRow(
                subTitle: "温度",
                weatherData: "\(doubleToString(source: weatherDetail.currentTemp)) 度"
            )
            weatherDataRow(
                subTitle: "湿度",
                weatherData: "\(weatherDetail.humidity) %"
            )
        }
    }

    @ViewBuilder private var tempDiffAreas: some View {
        VStack {
            Text("\(weatherDetail.cityName)と各地の気温差について")
                .font(.title2)
            
            ScrollView {
                if let minCity = minTempCityWeather {
                    let minTempDiff = calcTempDiff(
                        temp: minCity.currentTemp,
                        targetTemp: weatherDetail.currentTemp
                    )
                    Text("日本で平均気温が低い「\(minCity.cityName)（現在\(doubleToString(source: minCity.currentTemp))度）」より\(minTempDiff)度暖かいです")
                        .padding(.bottom, 6)
                }
                if let maxCity = maxTempCityWeather {
                    let maxTempDiff = calcTempDiff(
                        temp: maxCity.currentTemp,
                        targetTemp: weatherDetail.currentTemp
                    )
                    Text("日本で平均気温が高い「\(maxCity.cityName)（現在\(doubleToString(source: maxCity.currentTemp))度）」より\(maxTempDiff)度低いです")
                }
            }
            .padding()
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .center)
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
                    .padding(3)
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
            .background(Color.clear)
            .padding(.all,2)
        }
    }
}


#Preview {
    WeatherDetailView(weatherDetail: .preview, minTempCityWeather: .preview, maxTempCityWeather: .preview)
}
