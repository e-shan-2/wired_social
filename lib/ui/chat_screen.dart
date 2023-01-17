import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wired_social/provider/chat_provider.dart';
import 'package:wired_social/utils/app_assets.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_style.dart';
import 'package:wired_social/widgets/text_formfield.dart';

class ChatScreenUi extends StatefulWidget {
  // final Map<String, dynamic>? userMap;
  final String chatRoomId;
  final userList;

  const ChatScreenUi(
      {required this.userList, required this.chatRoomId, Key? key})
      : super(key: key);

  @override
  State<ChatScreenUi> createState() => _ChatScreenUiState();
}

class _ChatScreenUiState extends State<ChatScreenUi> {
  late TextEditingController _messageController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    // double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    // final Stream<QuerySnapshot> userList =
    // FirebaseFirestore.instance.collection(AppStrings.users).snapshots();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.greyColor,
        backgroundColor: AppColor.chatAppBarColour,
        leading: Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            // Expanded(
            //   child: CircleAvatar(
            //     backgroundImage: NetworkImage(AppAssetsImage.privacyLogo),
            //     // NetworkImage(widget.userMap![AppStrings.profilePic])

            //     // AssetImage(AppAssetsImage.aboutLogo)
            //   ),
            // ),
          ],
        ),
        centerTitle: true,
        title: Text(
          "",
          // widget.userMap![AppStrings.name],
          style: AppTextStyle.appBArTitle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: _screenHeight * 0.8,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("ChatRoomList2")
                    .doc(widget.chatRoomId)
                    .collection("ChatRoomList")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;

                          return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [message(_screenSize, map)]);
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            ),

            // StreamBuilder(builder: )

            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                        labelText: AppStrings.sendMessage,
                        controller: _messageController),
                  ),
                  Consumer<ChatProvider>(
                    builder: (context, _chatProvider, child) {
                      return IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () async {
                          await _chatProvider.sendMessage(
                            widget.userList,
                            _messageController,
                            _auth.currentUser!.uid,
                            widget.chatRoomId,
                            widget.userList[1],
                          );
                          // _chatProvider.onSendMessage(_messageController,
                          //     widget.chatRoomId, widget.userMap);
                        },
                        icon: const Icon(Icons.send),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget message(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment:
          // send by displayName
          map["id"] == _auth.currentUser!.uid
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: map["id"] == _auth.currentUser!.uid ? 40 : 5,
            right: map["id"] == _auth.currentUser!.uid ? 5 : 40),
        decoration: map["id"] == _auth.currentUser!.uid
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.greyBlueColor)
            : BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.recepientColour),
        child: map["id"] == _auth.currentUser!.uid
            ? Text(
                map["lastMessage"],
                style: AppTextStyle.messagebubble
                    .copyWith(color: AppColor.whiteColor),
              )
            : Text(
                map["lastMessage"],
                style: AppTextStyle.messagebubble,
              ),
      ),
    );
  }
}
