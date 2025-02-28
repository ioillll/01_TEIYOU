import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/user_model.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.userData});
  final UserModel userData;


  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  

  // TODO: 後で消す：ユーザーID
  final userDocId = '0N6dxccbr51zLE99slSs';
  
  @override
  Widget build(BuildContext context) {
    final userNameTextController = TextEditingController(text: widget.userData.name);
    final iconUrlTextController = TextEditingController(text: widget.userData.iconUrl);
    final selfIntroTextController = TextEditingController(text: widget.userData.selfIntroText);
    final locationTextController = TextEditingController(text: widget.userData.location);

    return Scaffold(
      appBar: AppBar(title: const Text('プロフィール編集')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: userNameTextController,
                decoration: const InputDecoration(
                  hintText: 'ユーザー名',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: iconUrlTextController,
                      decoration: const InputDecoration(
                        hintText: 'ユーザーアイコンURL',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text('更新'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.network(
                    iconUrlTextController.text,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: selfIntroTextController,
                  maxLines: 5,
                  decoration:  InputDecoration(
                    hintText: '自己紹介文',
                    enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: locationTextController,
                  decoration: const InputDecoration(
                    hintText: '場所',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: ElevatedButton(
                  onPressed: () async {
                    // ユーザーデータをクラウドに保存
                    final userName = userNameTextController.text;
                    final iconUrl = iconUrlTextController.text;
                    final selfIntroText = selfIntroTextController.text;
                    final location = locationTextController.text;

                    await FirebaseFirestore.instance.collection('users').doc(userDocId).update({
                      'name': userName,
                      'iconUrl': iconUrl,
                      'selfIntroText': selfIntroText,
                      'location': location,
                      'updated_at': Timestamp.now(),
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('保存'),
                ),
              ),
          ],
        ),
      ),
    );
    
  }
}