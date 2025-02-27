import 'package:flutter/material.dart';
import 'prefectures.dart';
import 'dart:convert'; // jsonDecodeを使うため


class SelectPrefecturePage extends StatefulWidget {
  const SelectPrefecturePage({Key? key}) : super(key: key);

  @override
  _SelectPrefecturePageState createState() => _SelectPrefecturePageState();
}

class _SelectPrefecturePageState extends State<SelectPrefecturePage> {

  late final List<Map<int, String>> _prefectures; // 都道府県名を格納するリスト

  @override
  void initState() {
    super.initState();
    _prefectures = _loadPrefectures(); // 同期的に都道府県データを読み込む
  }

   // 同期的に都道府県データを読み込む関数
  List<Map<int, String>> _loadPrefectures() {
    final Map<String, dynamic> json = jsonDecode(jsonStringPrefecture);
    final List<Map<int, String>> prefectureList = [];

    json['prefecturesCode'].forEach((key, value) {
      // 都道府県コード(key)をintに変換してMapに追加
      prefectureList.add({int.parse(key): value});
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
            onTap: () {
              // 選択された都道府県名を前の画面に返す
              Navigator.of(context).pop(_prefectures[index].values.first);
            },
          );
        },
      ),
    );
  }
}