import 'package:flutter/material.dart';
import 'package:tutorial_1/home_page.dart';

import 'profile_page.dart';


/// ボトムナビゲーションを実装
/// 下記ページを切り替えるページ
/// - ホーム（HomePage）
/// - プロフィール（ProfilePage）
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int _selectedIndex = 0;
  final pages = [
    const MyHomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        items:  const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'home' ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile' ),
      ],),
      );
  }
}