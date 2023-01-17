// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wired_social/provider/chat_provider.dart';
import 'package:wired_social/ui/chat_screen.dart';
import 'package:wired_social/utils/app_routes.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/widgets/list_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;

  String chatRoomId(String firstUser, String secondUser) {
    if (firstUser[0].toLowerCase().codeUnits[0] >
        secondUser.toLowerCase().codeUnits[0]) {
      return "$firstUser$secondUser";
    } else {
      return "$secondUser$firstUser";
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> messageFeed =
    //     FirebaseFirestore.instance.collection(AppStrings.chatRoom).snapshots();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.currentUser!.displayName;
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.groupChat);
            },
            icon: Icon(Icons.more_vert))
      ]),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // print('eshand ${snapshot.data.docs.g}');

          if (snapshot.hasError) {
            return const Text(AppStrings.somethingwentWrong);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text(AppStrings.loading);
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var datavalue = snapshot.data!.docs;

                if (datavalue[index][AppStrings.uid] !=
                    _auth.currentUser!.uid) {
                  return Consumer<ChatProvider>(
                      builder: (context, _chatProvider, child) {
                    List userList = [_auth.currentUser!.uid];

                    return ListTileMessageClass(
                        networkImage:
                            "${datavalue[index][AppStrings.profilePic]}",
                        onTap: () async {
                          List dataItem = [
                            _auth.currentUser!.uid,
                            datavalue[index][AppStrings.uid]
                          ];
                          String? documentId =
                              await _chatProvider.generateDocumentId(dataItem);
                          // print(
                          //     await _chatProvider.generateDocumentId(dataItem));

                          // Map<String, dynamic> dataItem =
                          //     datavalue[index].data() as Map<String, dynamic>;

                          //  print(documentId);

                          String roomId = _chatProvider.chatRoomId(
                              _auth.currentUser!.uid,
                              datavalue[index][AppStrings.uid]);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChatScreenUi(
                                  chatRoomId: documentId!,
                                  userList: dataItem)));
                        },
                        title: "${datavalue[index][AppStrings.name]}",
                        subTitile: AppStrings.appName);
                  });
                }
                return Container();
                // return ListTileMessageClass(
                //   onTap: () {
                //     Map<String, dynamic> dataItem =
                //         datavalue[index].data() as Map<String, dynamic>;

                //     String roomId = chatRoomId(_auth.currentUser!.uid,
                //         datavalue[index][AppStrings.uid]);
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (_) => ChatScreenUi(
                //             chatRoomId: roomId, userMap: dataItem)));
                //   },
                //   title: "${datavalue[index][AppStrings.name]}",
                //   subTitile: AppStrings.appName,
                // \);
              });
        },
      )),
    );
  }
}
