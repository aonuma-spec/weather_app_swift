//
//  ContentView.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/12.
//

import SwiftUI

struct ContentView: View {
    @State var selectedCity: CityModel = Constants.CITY_MODELS.first!
    @StateObject private var presenter = AppDI.makePresenter()
    
    var body: some View {
        NavigationStack {
            VStack {
                // 画像
                topImage
                // 地域選択のプルダウン
                cirtPicker
                    .padding(.top, 24)
                // 地域送信ボタン
                weatherSubmitBtn
                    .padding(.top, 18)
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
                    WeatherDetailView(weatherDetail: detail)
                }
            }
        }
    }

    /**
     トップ画像
     */
    @ViewBuilder private var topImage: some View {
        Image("job_otenki_oneesan")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 300)
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
