import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wired_social/utils/app_string.dart';

class GroupModel {
   List? users;
  List? admin;
  String? profilePic;
  String? description;
 String? lastMessage;


  String idFrom;
  String idTo;
  FieldValue timestamp;


  GroupModel({
   required this.lastMessage,
    required this.users,
    required this.admin,
    required this.description,
    required this.profilePic,
    required this.idFrom,
    required this.idTo,
    required this.timestamp
 
    

  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   data[AppStrings.users] = users;
    data[AppStrings.admin] = admin;
    data[AppStrings.description] = description;
    data[AppStrings.profilePic] = profilePic;
   data[AppStrings.lastMessage] = lastMessage;
    data[AppStrings.id] = idFrom;
    data[AppStrings.idTo] = idTo;
    data[AppStrings.timestamp] = timestamp;



    // data[AppStrings.type]=type;

    return data;
  }
}
