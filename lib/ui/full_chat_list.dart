import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wired_social/provider/chat_provider.dart';
import 'package:wired_social/ui/chat_screen.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_style.dart';
import 'package:wired_social/widgets/list_tile.dart';
import 'package:wired_social/widgets/searchbar.dart';

// class FullChatList extends StatefulWidget {
//   const FullChatList({Key? key}) : super(key: key);

//   @override
//   State<FullChatList> createState() => _FullChatListState();
// }

// class _FullChatListState extends State<FullChatList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// ignore_for_file: avoid_print

class FullChatList extends StatefulWidget {
  const FullChatList({Key? key}) : super(key: key);

  @override
  State<FullChatList> createState() => _FullChatListState();
}

class _FullChatListState extends State<FullChatList> {
  Map<String, dynamic>? userMap;
  List<Map<String, dynamic>> userSearchChat = [];
  List<Map<String, dynamic>> userList = [];
  bool isLoading = false;

  late TextEditingController _searchController;

  // void searchfunction(
  //   String data,
  // ) async {
  //   List<Map<String, dynamic>> userList = [];

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection(AppStrings.users)
  //         .where(AppStrings.name, arrayContains: data)
  //         .get()
  //         .then((value) {
  //       for (int j = 0; j <= value.docs.length - 1; j++) {
  //         userList.add(value.docs[j].data());

  //         String name = userList[j][AppStrings.name];

  //         name = name.toLowerCase();

  //         if (name.contains(data.toLowerCase())) {
  //           userSearchChat.add(userList[j]);

  //         }
  //       }

  //       setState(() {});
  //     });
  //   } catch (e) {
  //     throw "$e";
  //   }
  // }

  void storeResult() async {
    userList = [];
    await FirebaseFirestore.instance
        .collection(AppStrings.users)
        .get()
        .then((value) {
      setState(() {
        userList = value.docs.map((e) => e.data()).toList();
        print(userMap);
      });
    });
  }

  void onSearch(String data) {
    userSearchChat = [];

    for (int i = 0; i < userList.length; i++) {
      String name = userList[i][AppStrings.name];

      name = name.toLowerCase();
      if (name.contains(data.toLowerCase())) {
        userSearchChat.add(userList[i]);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    storeResult();
    onSearch("");
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

    // final Stream<QuerySnapshot> userList =
    //     FirebaseFirestore.instance.collection(AppStrings.users).snapshots();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.currentUser!.displayName;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          foregroundColor: AppColor.gradientColour,
          backgroundColor: AppColor.whiteColor,
          floating: true,
          pinned: true,
          snap: false,
          centerTitle: true,
          title: const Text(
            AppStrings.searchUpperCase,
            style: AppTextStyle.appBArTitle,
          ),
          bottom: AppBar(
            backgroundColor: AppColor.whiteColor,
            automaticallyImplyLeading: false,
            title: SearchBar(
              onChanged: (data) {
                onSearch(data);
              },
              title: AppStrings.search,
              controller: _searchController,
            ),
          ),
        ),
        // Other Sliver Widgets
        SliverFillRemaining(
          child: _searchController.text.isEmpty
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(AppStrings.users)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              return ListTileMessageClass(
                                  networkImage:
                                      "${datavalue[index][AppStrings.profilePic]}",
                                  onTap: () async {
                                    List dataItem = [
                                      _auth.currentUser!.uid,
                                      datavalue[index][AppStrings.uid]
                                    ];
                                    String? documentId = await _chatProvider
                                        .generateDocumentId(dataItem);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => ChatScreenUi(
                                                chatRoomId: documentId!,
                                                userList: dataItem)));
                                  },
                                  title: "${datavalue[index][AppStrings.name]}",
                                  subTitile: datavalue[index]
                                      [AppStrings.email]);
                            });
                          }
                          return Container();
                        });
                  },
                )
              : userSearchChat.isNotEmpty
                  ? Consumer<ChatProvider>(
                      builder: (context, _chatProvider, child) {
                      return ListView.builder(
                          itemCount: userSearchChat.length,
                          itemBuilder: (context, index) {
                            if (userSearchChat[index][AppStrings.name] !=
                                _auth.currentUser!.displayName) {
                              return ListTileMessageClass(
                                  networkImage:
                                      "${userSearchChat[index][AppStrings.profilePic]}",
                                  onTap: () async {
                                    // String roomId = _chatProvider.chatRoomId(
                                    //     _auth.currentUser!.uid,
                                    //     userSearchChat[index][AppStrings.uid]);

                                    List dataItem = [
                                      _auth.currentUser!.uid,
                                      userSearchChat[index][AppStrings.uid]
                                    ];
                                    String? documentId = await _chatProvider
                                        .generateDocumentId(dataItem);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => ChatScreenUi(
                                                chatRoomId: documentId!,
                                                userList:
                                                    userSearchChat[index])));
                                  },
                                  title: userSearchChat[index][AppStrings.name],
                                  subTitile: "");
                            }
                            return Container();
                          });
                    })
                  : const Center(
                      child: Text(
                      AppStrings.noResultFound,
                      style: AppTextStyle.appBArTitle,
                    )),
        )
      ],
    ));
  }
}
