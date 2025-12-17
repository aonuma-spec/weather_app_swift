//
//  ContentView.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/12.
//

import SwiftUI

struct ContentView: View {
    // 初期選択する地域
    @State var selectedCity: CityModel = Constants.CITY_MODELS.first!
    
    // DIを設定
    @StateObject private var presenter = AppDI.makePresenter()
    
    // 画面のPortlate, landScapeの設定用
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationStack {
            Group {
                if verticalSizeClass == .compact {
                    // 横向き
                    HStack {
                        // 画像
                        topImage(landscape: true)
                        // 地域選択のプルダウン
                        VStack {
                            Text("地域を選択してください")
                            cirtPicker
                                .padding(.top, 24)
                            // 地域送信ボタン
                            weatherSubmitBtn
                                .padding(.top, 18)
                        }
                        .padding(.leading,72)
                    }
                } else {
                    VStack {
                        // 縦向き
                        // 画像
                        topImage(landscape: false)
                        Text("地域を選択してください")
                        // 地域選択のプルダウン
                        cirtPicker
                        // 地域送信ボタン
                        weatherSubmitBtn
                            .padding(.top, 18)
                    }
                }
            }
            // アプリタイトル
            .navigationTitle("天気アプリ")
            .toolbarBackground(
                Color(red: 0x38/255.0,
                      green: 0x58/255.0,
                      blue: 0x51/255.0),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            
            //天気詳細画面への遷移
            .navigationDestination(
                isPresented: Binding(get: {presenter.weatherDetail != nil},
                                     set: {_ in presenter.weatherDetail = nil}
                                    )
            ) {
                if let detail = presenter.weatherDetail {
                    WeatherDetailView(
                        weatherDetail: detail,
                        minTempCityWeather: presenter.minTempCityWeather,
                        maxTempCityWeather: presenter.maxTempCityWeather
                    )
                }
            }
        }
        // Presenterのエラー状態を監視してAlert表示
        .alert(isPresented: $presenter.hasError) {
            Alert(
                title: Text("エラー"),
                message: Text(presenter.errorMessage ?? "不明なエラー"),
                dismissButton: .default(Text("OK")) {
                    presenter.hasError = false // Alert閉じたらフラグリセット
                }
            )
        }
    }
    
    /**
     トップ画像
     */
    @ViewBuilder
    private func topImage(landscape: Bool) -> some View {
        let size: CGFloat = landscape ? 200 : 300

        Image("job_otenki_oneesan")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: size)
    }
    
    /**
     地域選択のプルダウン
     */
    @ViewBuilder private var cirtPicker: some View {
        
        Picker("地域を選択", selection: $selectedCity) {
            ForEach(Constants.CITY_MODELS) {city in
                Text(city.cityName).tag(city)
            }
        }
        .pickerStyle(.menu)
    }
    
    /**
     地域送信ボタン
     */
    @ViewBuilder private var weatherSubmitBtn: some View {
        Button(action: {
            presenter.onCitySubmitButtonClicked(selectedCity: selectedCity.cityValue)
        })
        {
            Text("送信する")
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.blue)
    }
}


#Preview {
    ContentView()
}
