import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wired_social/utils/app_string.dart';

class ChatMessageModel {
  String idFrom;
  String idTo;
  FieldValue timestamp;
  String lastMessage;
     List? users;
//  int type;

  ChatMessageModel({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.lastMessage,
    required this.users,
    //  required this.type
  });
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[AppStrings.id] = idFrom;
    data[AppStrings.idTo] = idTo;
    data[AppStrings.timestamp] = timestamp;
    data[AppStrings.lastMessage] = lastMessage;
    data[AppStrings.users]=users;

    return data;
  }

  factory ChatMessageModel.fromJson(Map<String,dynamic>json


    ) {
    String idFrom = json[AppStrings.idFrom];
    String idTo = json[AppStrings.idTo];
    FieldValue timestamp = json[AppStrings.timestamp];
    String lastMessage=json[AppStrings.lastMessage];
    List users=json[AppStrings.users];
 
    //  int type = documentSnapshot.get(AppStrings.type);
    return ChatMessageModel(
      idFrom: idFrom,
      idTo: idTo,
      timestamp: timestamp,
      lastMessage: lastMessage,
      users: users,
    );
  }
}
