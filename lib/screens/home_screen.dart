import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/api/apis.dart';
import 'package:we_chat/models/chat_user.dart';
import 'package:we_chat/widget/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(CupertinoIcons.home),
          title: const Text('We Chat'),
          // For actions button
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton(
              onPressed: () async {
                await APIs.auth.signOut();
                await GoogleSignIn().signOut();
              }, child: Icon(Icons.login_rounded)),
        ),

        //For getting real time data using StreamBuilder
        body: StreamBuilder(
            stream: APIs.firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              //if the connection is not succeeded
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
                //if the connection is good and succeeded
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                          [];
                  // for (var i in data!) {
                  //   print(jsonEncode(i.data()));
                  //   list.add(i.data()['about']);
                  // }
                  if (list.isNotEmpty) {
                    return ListView.builder(
                        itemCount: list.length,
                        padding: const EdgeInsets.only(top: 2),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return ChatUserCard(user: list[index]);
                          // return Text(list[index]);
                        }));
                  } else {
                    return const Center(
                        child: Text(
                      'No Connections Found',
                      style: TextStyle(fontSize: 20),
                    ));
                  }
              }
            }));
  }
}
