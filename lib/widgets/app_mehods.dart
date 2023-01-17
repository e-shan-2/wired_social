import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wired_social/utils/app_string.dart';

class AppMethods{
 void onSearch( String value,Map<String,dynamic>userMap) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
 
    await _fireStore
        .collection(AppStrings.users)
        .where(AppStrings.email, isEqualTo: value)
        .get()
        .then((value) {
     
        userMap = value.docs[0].data();
     
    });

   
  }


}