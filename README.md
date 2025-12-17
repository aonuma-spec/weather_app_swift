# weather_app_swift

Swiftで作成した天気アプリ。\
Weather APIからデータを取得し、画面に表示します。

## スクリーンショット
<!--![アプリのスクリーンショット1]()-->
<!--![アプリのスクリーンショット2]()-->

## 使用技術
- Xcode
- Swift

## 環境変数
- ENV_API_ENDPOINT: Weather APIを実行するためのURLとAPIキーの値を設定（クエリの地域名以外を設定）

## ディレクトリ構成
weatherAppSwift\
├─ data\
│  ├─ model\
│  │  ├─ CityModel.swift\
│  │  ├─ WeatherApiResponseModel.swift\
│  │  └─ WeatherDetailModel.swift\
│  └─ repository\
│     ├─ WeatherAPIService.swift\
│     ├─ WeatherRepository.swift\
│     └─ WeatherResponseRepository.swift\
├─ di\
│  └─ AppDI.swift\
├─ presenter\
│  ├─ MainContract.swift\
│  ├─ MainPresenter.swift\
│  ├─ WeatherDetailContract.swift\
│  └─ WeatherDetailPresenter.swift\
├─ ui\
│  ├─ common\
│  │  └─ ErrorView.swift\
│  ├─ ContentView.swift\
│  └─ WeatherDetailView.swift\
└─ util\
&nbsp;&nbsp;&nbsp;└─ Constants.swift\

