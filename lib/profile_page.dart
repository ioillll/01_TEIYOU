import 'dart:math';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー名'),
        actions: const [SignOutButton(variant: ButtonVariant.text,)],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/4/48/Portrait_gallery_of_eminent_men_and_women_of_Europe_and_America_-_embracing_history%2C_statesmanship%2C_naval_and_military_life%2C_philosophy%2C_the_drama%2C_science%2C_literature_and_art%2C_with_biographies_%281873%29_%2814794569243%29.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Text("自己紹介文\n hello, I'm from 19th century, call me."),
            Text("位置情報\n England"),
          ],
        ),
      ),
    );
  }
}