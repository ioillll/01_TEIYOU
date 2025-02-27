import 'package:flutter/material.dart';
import 'select_prefecture_page.dart';

// 1. エントリーポイントのmain関数
void main() {
  // 2. MyAppを呼び出す
  runApp(const MyApp());
}

// MyAppのクラス
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3. タイトルとテーマを設定する。画面の本体はMyHomePageで作る。
    return MaterialApp(
      title: '今日の天気', // タイトル,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '今日の天気'), // アプリのホーム画面
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedPrefecture;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // 4. MyHomePageの画面を構築する部分
    return Scaffold(
      // 画面上部のタイトル部分
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 画面の中央に表示されるテキス
             Container(
             width: size.width * 0.8,
             height: size.height * 0.5,
              decoration: BoxDecoration(
              border: Border.all(color: Colors.blue), // 青色の枠線
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
               child: Text('今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気今日の天気', style: TextStyle(fontSize: 20,),),
             ),
           ),
           // 都道府県の選択ボタn
           Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async { // async を追加
                  // 都道府県選択画面に遷移し、戻り値を受け取る
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectPrefecturePage()),
                  );

                  // 戻り値がある場合、状態を更新
                  if (result != null) {
                    setState(() {
                      _selectedPrefecture = result as String?;
                    });
                  }
                },
                child: Text(_selectedPrefecture != null
                    ? '選択済み: ${_selectedPrefecture}' // 選択された都道府県名を表示
                    : '都道府県を選択'), // 選択されていない場合はデフォルトのテキストを表示
              ),
            ),
          ],
        ),
      ),
      // 右下の「+」ボタンに対応するフローティングアクションボタン
    );
  }
}