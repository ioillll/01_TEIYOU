import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_1/model/weather_response.dart';
import 'package:tutorial_1/select_prefecture_page.dart';
import 'auth_gate.dart';

import 'firebase_options.dart';

// 最初に実行される関数
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  
  // runApp関数でMyAppクラスを実行
  runApp(const MyApp());
}

// MyAppクラス (アプリ全体) StatelessWidgetを継承
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // buildメソッド
  @override
  Widget build(BuildContext context) {
    // MaterialAppクラスでMaterialAppを実行
    return MaterialApp(
      title: '今日の天気', // タイトル
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ), // アプリ全体のテーマ
      home: const AuthGate(),
      // const MyHomePage(title: '今日の天気'), // アプリのホーム画面
    );
  }
}