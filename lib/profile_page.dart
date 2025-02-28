import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'edit_profile_page.dart';
import 'model/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // TODO: 後で消す：ユーザーID
  final userDocId = '0N6dxccbr51zLE99slSs';
  
  // // ユーザーデータのローカルデータ
  // final userData = UserModel(
  //   name: '山田太郎',
  //   iconUrl: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-1/473718037_4029606000692996_7770912165618292230_n.jpg?stp=dst-jpg_s480x480_tt6&_nc_cat=102&ccb=1-7&_nc_sid=e99d92&_nc_ohc=4LyGu9tu6SIQ7kNvgG2SdkJ&_nc_oc=AdiqhXp3aL-pSv4vjSIKfN7NhYp_GwO0yrhB1GN1wuc4oudzATrOLpeEqv5iBy_IVfQ&_nc_zt=24&_nc_ht=scontent-nrt1-2.xx&_nc_gid=AwSXMFxFxJ6yWwIsH4Mt_kM&oh=00_AYDJRLwRL_dBMdZCQ1JKRac-xqLe1ozGedIg2fNuaKLbLw&oe=67AA2AD8',
  //   selfIntroText: 'こんにちは！山田太郎です。',
  //   location: '沖縄県',
  // );

  // @override
  // void initState() async {
  //   super.initState();

  //   // ユーザーデータの取得
  //   Future(() async {
  //     final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userDocId).get();
  //     final userDocData = userDoc.data() as Map<String, dynamic>;
  //     userData.name = userDocData['name'];
  //     userData.iconUrl = userDocData['iconUrl'];
  //     userData.selfIntroText = userDocData['selfIntroText'];
  //     userData.location = userDocData['location'];
  //   });
  // }


  // futureBuilderにセットするfuture関数
Future<UserModel> fetchUserData() async {
  print("fetchUserData() is being called...");

  try {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userDocId).get();

    if (!userDoc.exists) {
      print("Error: No user found for ID $userDocId");
      throw Exception("User not found");
    }

    final userDocData = userDoc.data() as Map<String, dynamic>;

    // Debugging: Print the entire Firestore response
    print("Firestore Response: $userDocData");

    // Check what `iconUrl` actually is
    print("Type of iconUrl: ${userDocData['iconUrl'].runtimeType}");

    final userData = UserModel(
  name: userDocData['name'] ?? "No Name",
  iconUrl: userDocData['iconUrl'] ?? "",
  selfIntroText: userDocData['selfIntroText'] ?? "",
  location: userDocData['location'] is Map
      ? userDocData['location']['prefectureName'] ?? "Unknown"
      : "Unknown",
);


    print("Profile Image URL: ${userData.iconUrl}");

    return userData;
  } catch (e) {
    print("Error fetching user data: $e");
    throw e;
  }
}


  // Future<UserModel> fetchUserData() async {
  //   print("fetchUserData() is being called...");
    
  //   final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userDocId).get();
  //   final userDocData = userDoc.data() as Map<String, dynamic>;
  //   final userData = UserModel(
  //     name: userDocData['name'],
  //     iconUrl: userDocData['iconUrl'],
  //     selfIntroText: userDocData['selfIntroText'],
  //     location: userDocData['location'],
  //   );
  //   print("Profile Image URL: ${userData.iconUrl}");

  //   return userData;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('エラーが発生しました'),
            ),
          );
        }

        final userData = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(userData.name),
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
                    userData.iconUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(userData.selfIntroText),
                Text(userData.location),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SignOutButton(),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                         MaterialPageRoute(
                          builder: (context) {
                            return EditProfilePage(userData: userData,);
                          },
                        ),
                      );
                      }, 
                      child: const Row(children: [
                        Icon(Icons.edit),
                        Text('プロフィール編集'),
                      ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}