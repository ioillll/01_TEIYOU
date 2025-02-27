import 'package:flutter/material.dart';
import 'prefectures.dart';
import 'dart:convert'; // jsonDecodeを使うため
import 'package:http/http.dart' as http; // httpリクエストを送信するため
import './model/weather_model.dart'; // 天気予報のモデルクラス


class SelectPrefecturePage extends StatefulWidget {
  const SelectPrefecturePage({Key? key}) : super(key: key);

  @override
  _SelectPrefecturePageState createState() => _SelectPrefecturePageState();
}

class _SelectPrefecturePageState extends State<SelectPrefecturePage> {

  late final List<Map<String, String>> _prefectures; // 都道府県名を格納するリスト

  @override
  void initState() {
    super.initState();
    _prefectures = _loadPrefectures(); // 同期的に都道府県データを読み込む
  }

   // 同期的に都道府県データを読み込む関数
  List<Map<String, String>> _loadPrefectures() {
    final Map<String, dynamic> json = jsonDecode(jsonStringPrefecture);
    final List<Map<String, String>> prefectureList = [];

    json['prefecturesCode'].forEach((key, value) {
      // 都道府県コード(key)をintに変換してMapに追加
      prefectureList.add({key: value});
    });

    return prefectureList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('都道府県選択'),
      ),
      body: ListView.builder(
        itemCount: _prefectures.length, // 都道府県の数
        itemBuilder: (BuildContext context, int index) {

          return ListTile(
            title: Text(_prefectures[index].values.first), // 都道府県名を表示
             onTap: () async{

              // 選択された都道府県の天気予報を取得
              final WeatherResponse weather = await fetchWeather(
                  _prefectures[index].keys.first);
              Navigator.of(context).pop(weather);
            },
          );
        },
      ),
    );
  }

  Future<WeatherResponse> fetchWeather(String areaCode) async {

    final response = await http.get(
      Uri.parse('https://www.jma.go.jp/bosai/forecast/data/overview_forecast/$areaCode.json'),
      headers: {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36',
        'Accept': 'application/json',
      },
    );
    final String responseBody = utf8.decode(response.bodyBytes);

    print(responseBody);
    print(response.headers);

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('天気予報の取得に失敗しました');
    }
  }
}
