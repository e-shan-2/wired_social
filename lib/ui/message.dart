import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wired_social/provider/chat_provider.dart';
import 'package:wired_social/ui/chat_screen.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_routes.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_style.dart';

import 'package:wired_social/widgets/list_tile.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late TextEditingController _searchController;

  List<Map<String, dynamic>> userUpdatedMap = [];
  List<Map<String, dynamic>> userSearchChat = [];
  bool isLoading = false;
  bool namechange = false;

  bool chatListValue = false;

  // Function for checking the same user or not

  void userSameOrNot() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    await _fireStore
        .collection(AppStrings.users)
        .where(
          AppStrings.uid,
        )
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        userUpdatedMap.add(value.docs[i].data());
      }
    });
  }

  List<Map<String, dynamic>> value = [];

  @override
  void initState() {
    userSameOrNot();

    _searchController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // double _screenHeight = MediaQuery.of(context).size.height;

    // double _screenWidth = MediaQuery.of(context).size.width;
    //    List<Map<String, dynamic>?> chatUser = [];
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        value = await Provider.of<ChatProvider>(context, listen: false)
            .userList(_auth.currentUser!.uid);
       
        setState(() {});

        // for (int i = 0; i < value.length; i++) {
        //   if (value[i]["uid"].length == 2) {
        //     String data = value[i]["uid"][1];
        //     chatUser.add(await Provider.of<ChatProvider>(context, listen: false)
        //         .getuserDataBydocumentId("users", data));
        //     print(chatUser[0]![AppStrings.profilePic]);
        //   } else {
        //     chatUser.add(await Provider.of<ChatProvider>(context, listen: false)
        //         .getuserDataBydocumentId(
        //             "ChatRoomList2", value[i]["document"]));
        //   }
        // }
      },
    );

    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushNamed(context, AppRoutes.bottomTabBar,
            arguments: 1);

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          foregroundColor: AppColor.greyColor,
          title: const Text(
            AppStrings.message,
            style: AppTextStyle.appBArTitle,
          ),
        ),
        body: value.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Consumer<ChatProvider>(builder: (context, _chatProvider, child) {
                return StreamBuilder<QuerySnapshot>(
                  stream:
                      // stream for getting the user who have interacted with the current logined user
                      FirebaseFirestore.instance
                          .collection("ChatRoomList2")
                          // .doc(_auth.currentUser!.uid)
                          // .collection(AppStrings.chatRoomList)
                          .orderBy(AppStrings.timestamp, descending: true)
                          .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text(AppStrings.somethingwentWrong);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(AppStrings.loading);
                    }
                    // print(snapshot.data!.docs[0].data()!["lastMessage"]);

                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var dataItem = snapshot.data!.docs;
                          // print(dataItem[index].data()!["lastMessage"]["content"]);

                          Map<String, dynamic> datavalue =
                              dataItem[index].data() as Map<String, dynamic>;
                          // print(datavalue["users"][1]);
                          // print("######################");
                          // print(value[index]["uid"]);
                          // if(datavalue["users"][1]==value[index]["uid"]){

                          // }

                          return
                              // Text("data");

                              ListTileMessageClass(
                                  networkImage: value[index]
                                      [AppStrings.profilePic],
                                  onTap: () {
                                    String roomId = _chatProvider.chatRoomId(
                                        _auth.currentUser!.uid,
                                        dataItem[index][AppStrings.uid]);

                                    // print(dataItem);
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (_) => ChatScreenUi(
                                    //         chatRoomId: roomId, userMap: datavalue)));
                                  },
                                  title: value[index][AppStrings.name],
                                  subTitile: datavalue["lastMessage"]);
                        });
                  },
                );
              }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.greyBlueColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.fullChatList);
            }),
      ),
    );
  }

// // it is for updating the user list
//   List<Map<String, dynamic>> checkUserList(
//       List<QueryDocumentSnapshot<Object?>> dataItem) {
//     List<Map<String, dynamic>> userdata = [];

//     for (int i = 0; i < userUpdatedMap.length; i++,) {
//       for (int j = 0; j < dataItem.length; j++) {
//         Map<String, dynamic> datavalue =
//             dataItem[j].data() as Map<String, dynamic>;
//         if (userUpdatedMap[i][AppStrings.uid] == datavalue[AppStrings.uid]) {
//           userdata.add(userUpdatedMap[i]);
//         }
//       }
//     }

//     return userdata;
//   }
}
