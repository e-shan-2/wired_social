import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wired_social/provider/chat_provider.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/widgets/circle.dart';
import 'package:wired_social/widgets/list_tile.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({Key? key}) : super(key: key);

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  List<Map<String, dynamic>> selectedUser = [];

  int doesItContainMap(List<Map<String, dynamic>> selectedUser, String data) {
    return selectedUser.indexWhere((element) => element.values.contains(data));
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
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

          return Column(
            children: [
              selectedUser.isEmpty
                  ? Container()
                  : SizedBox(
                      height: _screenHeight * 0.138,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedUser.length,
                          itemBuilder: (context, index) {
                            return Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  StoryWidget(
                                      text: true,
                                      title: selectedUser[index]
                                          [AppStrings.name],
                                      imageUrl: selectedUser[index]
                                          [AppStrings.profilePic]),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedUser.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      color: AppColor.greyBlueColor,
                                    ),
                                  ),
                                ]);
                          }),
                    ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var datavalue = snapshot.data!.docs;

                    if (datavalue[index][AppStrings.uid] !=
                        _auth.currentUser!.uid) {
                      return Consumer<ChatProvider>(
                          builder: (context, _chatProvider, child) {
                        List userList = [_auth.currentUser!.uid];
                        Map<String, dynamic> data =
                            datavalue[index].data() as Map<String, dynamic>;

                        // if(){

                        // }

                        return ListTileMessageClass(
                            networkImage:
                                "${datavalue[index][AppStrings.profilePic]}",
                            onTap: () async {
                              String team = data["uid"];
                              print(selectedUser.length);

                              int value = doesItContainMap(selectedUser, team);
                              if (value != -1) {
                                setState(() {
                                  selectedUser.removeAt(value);
                                });
                              } else {
                                setState(() {
                                  selectedUser.add(data);
                                });
                              }

                              // }

                              List dataItem = [
                                _auth.currentUser!.uid,
                                datavalue[index][AppStrings.uid]
                              ];
                              String? documentId = await _chatProvider
                                  .generateDocumentId(dataItem);

                              // print(
                              //     await _chatProvider.generateDocumentId(dataItem));

                              // Map<String, dynamic> dataItem =
                              //     datavalue[index].data() as Map<String, dynamic>;

                              //  print(documentId);

                              // String roomId = _chatProvider.chatRoomId(
                              //     _auth.currentUser!.uid,
                              //     datavalue[index][AppStrings.uid]);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (_) => ChatScreenUi(
                              //         chatRoomId: documentId!,
                              //         userList: dataItem)));
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
                  }),
            ],
          );
        },
      )),
    );
  }
}
