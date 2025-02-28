
// MyHomePageクラス (ホーム画面)  StatefulWidgetを継承
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'model/weather_response.dart';
import 'select_prefecture_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // final 修飾子で変更不可の変数を宣言 (コンストラクタで初期化)
  // createStateメソッド (Stateオブジェクトを返す)
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// _MyHomePageStateクラス (ホーム画面の状態) Stateを継承  _で始まるのはプライベートクラス(外部からアクセスできない)
class _MyHomePageState extends State<MyHomePage> {
  WeatherResponse? weatherData;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // buildメソッド
  @override
  Widget build(BuildContext context) {
    // 画面サイズを取得 final 修飾子で変更不可の変数を宣言
      final size = MediaQuery.of(context).size;

    // Scaffoldクラスで画面を構築
    return Scaffold(
      // AppBarウィジェット
      appBar: AppBar(
        title: const Text('今日の天気'), // タイトル
      ),
      // Centerクラスで中央揃え
      body: Center(
        // Columnクラスで縦に並べる
        child: Column(
          // 中央揃え
          mainAxisAlignment: MainAxisAlignment.center,
          // 子要素
          children: <Widget>[
           
           // 今日の天気表示エリア
           Container(
             width: size.width * 0.8,
             height: size.height * 0.5,
              decoration: BoxDecoration(
              border: Border.all(color: Colors.blue), // 青色の枠線
              borderRadius: BorderRadius.circular(10),// 枠線の角を丸くする
            ),
             child: SingleChildScrollView(
               child: Text(
                 (weatherData != null) ? weatherData!.text : '都道府県を選択してください',
                 style: const TextStyle(fontSize: 16),
               ),
             ),
           ),
           // 都道府県の選択ボタン
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: ElevatedButton(
             onPressed: () async {
              // 都道府県選択画面へプッシュ遷移
              weatherData = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SelectPrefecturePage(); // 遷移先の画面widgetを指定
                  },
                ),
              );
              setState(() {});
              
             },

             
             child: Text((weatherData != null) ? '都道府県を選択: ${weatherData!.targetArea}': '都道府県を選択'),
           ),
           ),
          ],
        ),
      ),
      
    );
  }
}
