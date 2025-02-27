import 'dart:convert';

import 'package:flutter/material.dart';

import 'prefectures.dart';

import 'const.dart';
import 'service/weather_api_service.dart';

class SelectPrefecturePage extends StatefulWidget {
  const SelectPrefecturePage({super.key});

  @override
  State<SelectPrefecturePage> createState() => _SelectPrefecturePageState();
}

class _SelectPrefecturePageState extends State<SelectPrefecturePage> {
  final prefecturesArr = [];

  @override
  Widget build(BuildContext context) {
    // 都道府県のjsonstringデータをMapに変換
    final prefecturesMap = jsonDecode(jsonStringPrefecture)["prefecturesCode"] as Map<String, dynamic>;
    // マップ型から配列に変換
    prefecturesMap.forEach((key, value) {
      prefecturesArr.add({key: value});
    }); 
    // print("=== prefecturesArr ===");
    // print(prefecturesArr);

    return Scaffold(
      appBar: AppBar(
        title: const Text('都道府県を選択'),
      ),
      body: ListView.builder(
      itemCount: prefecturesMap.length,
      itemBuilder: (context, index) {
        // print("=== index ===");  
        // print(index);
        print(prefecturesArr[index]);
        // print(prefecturesArr[index].values.first);
        return ListTile(
          title: Text(prefecturesArr[index].values.first),
          onTap: () async {
            final apiUrl  = url + endpoint + prefecturesArr[index].keys.first + '.json';
            print("=== apiUrl ===");
            print(apiUrl);
            final weatherData = await WeatherApiService().getWeather(apiUrl);
            print("=== weatherData ===");
            print(weatherData.targetArea);
            Navigator.pop(context, weatherData);
          },
        );
      },
    ),
    );
  }
}