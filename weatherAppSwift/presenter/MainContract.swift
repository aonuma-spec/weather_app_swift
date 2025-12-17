//
//  SwiftUIView.swift
//  weatherAppSwift
//
//  Created by 大沼　 on 2025/12/16.
//

struct MainContract {
    
    protocol Presenter {

        /**
         地域送信ボタンを押下した時に実行される関数
         */
        func onCitySubmitButtonClicked(selectedCity: String)
        
        /**
         エラー時の処理
         */
        func showError(_ error: Error)
    }
}

