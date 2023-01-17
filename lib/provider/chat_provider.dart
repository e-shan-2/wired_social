import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wired_social/model/chat_messag_model.dart';
import 'package:wired_social/model/group_des.dart';
import 'package:wired_social/utils/app_string.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void onSendMessage(TextEditingController messageController, String chatRoomId,
      Map<String, dynamic>? userMap) async {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        AppStrings.sendBy: _auth.currentUser!.displayName,
        AppStrings.messageSmallCase: messageController.text,
        AppStrings.time: FieldValue.serverTimestamp(),
      };
      await _firestore
          .collection(AppStrings.chatRoom)
          .doc(chatRoomId)
          .collection(AppStrings.chats)
          .add(message);
      // print()

      // Map<String, dynamic> chatRoomData = {"chatroomId": chatRoomId};

      userMap![AppStrings.time] = FieldValue.serverTimestamp();
      // Current user added with the user we are chatting with
      await _firestore
          .collection(AppStrings.users)
          .doc(_auth.currentUser!.uid)
          .collection(AppStrings.chatRoomList)
          .doc(userMap[AppStrings.uid])
          .set(userMap);
      messageController.clear();

      Map<String, dynamic> currentUserMap = {
        AppStrings.name: _auth.currentUser!.displayName,
        AppStrings.email: _auth.currentUser!.email,
        AppStrings.uid: _auth.currentUser!.uid,
        AppStrings.time: FieldValue.serverTimestamp(),
      };

      // user on the other end + current user

      await _firestore
          .collection(AppStrings.users)
          .doc(userMap[AppStrings.uid])
          .collection(AppStrings.chatRoomList)
          .doc(_auth.currentUser!.uid)
          .set(currentUserMap);
    } else {}
    notifyListeners();
  }

  Future<Map<String, dynamic>?> onSearch(
    TextEditingController _searchController,

    // bool isLoading
  ) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    Map<String, dynamic>? userMap;
    isLoading = true;

    await _fireStore
        .collection(AppStrings.users)
        .where(AppStrings.name, isEqualTo: _searchController.text)
        .get()
        .then((value) {
      userMap = value.docs[0].data();
    });

    isLoading = false;

    notifyListeners();
    return userMap;
  }

  Future<List<Map<String, dynamic>>?> searchfunction(
      String data, List<Map<String, dynamic>> userSearchChat) async {
    List<Map<String, dynamic>> userList = [];
    userSearchChat = [];

    await FirebaseFirestore.instance
        .collection(AppStrings.users)
        .where(
          AppStrings.name,
        )
        .get()
        .then((value) {
      // print(value.docs.length - 1);
      for (int j = 0; j <= value.docs.length - 1; j++) {
        userList.add(value.docs[j].data());

        String name = userList[j][AppStrings.name];

        if (name.contains(data)) {
          userSearchChat.add(userList[j]);
        } else {
          userSearchChat.remove;
        }
      }

      notifyListeners();
      return userSearchChat;
    });
    return null;
  }

  String chatRoomId(String firstUser, String secondUser) {
    if (firstUser[0].toLowerCase().codeUnits[0] >
        secondUser.toLowerCase().codeUnits[0]) {
      return "$firstUser$secondUser";
    } else {
      return "$secondUser$firstUser";
    }
  }

//This function is used for getting the chatroom collection which will be required in future

  Future<QuerySnapshot<Map<String, dynamic>>> getChatChatRoomFields() async {
    var x = await FirebaseFirestore.instance.collection("ChatRoomList2").get();

    return x;
  }

/* It is for checking if the conversation has taken place or not ,if it has then it will add the message in the  conversation,
  and if it hsent then first it will create chatroom and then add the conversation*/

  Future<void> sendMessage(
    List data,
    TextEditingController messageController,
    String sender,
    String documentIdString,
    String receiever, {
    List? admin,
    String? profilePic,
    String? description,
  }
      // {String? documentId}
      ) async {
    int c = 0;
    var value = await getChatChatRoomFields();

    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> _message = ChatMessageModel(
              idFrom: sender,
              idTo: receiever,
              timestamp: FieldValue.serverTimestamp(),
              lastMessage: messageController.text,
              users: data)
          .toJson();

      for (int i = 0; i < value.docs.length; i++) {
        String documentid = value.docs[i].id;
        await FirebaseFirestore.instance
            .collection("ChatRoomList2")
            .doc(documentid)
            .get()
            .then((value) {
          if (listEquals(value.data()!["users"], data)) {
            c++;

            FirebaseFirestore.instance
                .collection('ChatRoomList2')
                .doc(documentid)
                .collection("ChatRoomList")
                .add(_message);
            FirebaseFirestore.instance
                .collection('ChatRoomList2')
                .doc(documentid)
                .update(
                  _message,
                );
          }
        });
      }
      if (c == 0) {
        if (data.length == 2) {
          await FirebaseFirestore.instance
              .collection("ChatRoomList2")
              .doc(documentIdString)
              .collection("ChatRoomList")
              .add(_message);

          await FirebaseFirestore.instance
              .collection('ChatRoomList2')
              .doc(documentIdString)
              .set(_message);
        } else {
          await FirebaseFirestore.instance
              .collection("ChatRoomList2")
              .doc(documentIdString)
              .collection("ChatRoomList")
              .add(_message);

          Map<String, dynamic> _details = GroupModel(
                  admin: admin,
                  profilePic: profilePic,
                  users: data,
                  description: description,
                  idFrom: sender,
                  idTo: receiever,
                  timestamp: FieldValue.serverTimestamp(),
                  lastMessage: messageController.text)
              .toJson();

          await FirebaseFirestore.instance
              .collection('ChatRoomList2')
              .doc(documentIdString)
              .set(_details);
        }
      }

      messageController.clear();
    }
    notifyListeners();
  }

  generateDocumentId(List data) async {
    var value = await getChatChatRoomFields();

    int c = 0;

    for (int i = 0; i < value.docs.length; i++) {
      String documentid = value.docs[i].id;

      var x = await FirebaseFirestore.instance
          .collection("ChatRoomList2")
          .doc(documentid)
          .get()
          .then((value) {
        if (listEquals(value.data()!["users"], data)) {
          c++;

          return documentid;
        }
      });

      if (c > 0) {
        return x;
      }
    }

    if (c == 0) {
      var document =
          await FirebaseFirestore.instance.collection("ChatRoomList2").doc();
      // print(x.id);
      return document.id;
    }
  }

/*This function needs to be called in  the init state or in  the previous screen as it will give document id which is 
  required for accessing the messages*/

  Future<String?> getDocumentId(List data) async {
    var value = await getChatChatRoomFields();

    for (int i = 0; i < value.docs.length; i++) {
      String documentid = value.docs[i].id;
      print(documentid);
      print(data);
      await FirebaseFirestore.instance
          .collection("ChatRoomList2")
          .doc(documentid)
          .get()
          .then((value) {
        if (listEquals(value.data()!["users"], data)) {
          print(data);
          print(value.data()!["users"]);
          return documentid;
        }
      });
    }
    return null;
  }

  // For message screen

  Future<List<Map<String, dynamic>>> getInteractedContact(
      String currertUserId) async {
    var value = await getChatChatRoomFields();
    List<Map<String, dynamic>> dataItem = [];
    for (int i = 0; i < value.docs.length; i++) {
      String documentid = value.docs[i].id;
      await FirebaseFirestore.instance
          .collection("ChatRoomList2")
          .doc(documentid)
          .get()
          .then((value) {
        // print(value.data()!["users"]);

        if ((value.data()!["users"][0] == currertUserId)) {
          dataItem.add({
            "document": documentid,
            "uid": value.data()!["users"],
            "lastMessage": value.data()!["lastMessage"],
            "time": value.data()!["timestamp"],
          });
        }
      });
    }

    return dataItem;
  }

  Future<Map<String, dynamic>?> getuserDataBydocumentId(
      String collection, String documentId) async {
    var x = await _firestore.collection(collection).doc(documentId).get();
    return x.data();
  }

// first convert  Future<List<Map<String, dynamic>>> dataItem to List<Map<String, dynamic>> dataItem then only this function will work
  Future<List<Map<String, dynamic>>> userList(String currertUserId) async {
    List<Map<String, dynamic>> dataItem =
        await getInteractedContact(currertUserId);
    List<Map<String, dynamic>> userList = [];
    for (int i = 0; i < dataItem.length; i++) {
      if (dataItem[i]["uid"].length == 2) {
        Map<String, dynamic>? data =
            await getuserDataBydocumentId("users", dataItem[i]["uid"][1]);
        userList.add(data!);
      } else {
        Map<String, dynamic>? data = await getuserDataBydocumentId(
            "ChatRoomList2", dataItem[i]["document"]);
        userList.add(data!);
      }
    }
    notifyListeners();
    return userList;
  }
}
