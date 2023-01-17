import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_style.dart';
import 'package:wired_social/widgets/circle.dart';
import 'package:wired_social/widgets/feed_widget.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _dataController;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    _dataController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final Stream<QuerySnapshot> userList =
        FirebaseFirestore.instance.collection(AppStrings.users).snapshots();
    double _screenHeight = MediaQuery.of(context).size.height;

    // double _screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                AppStrings.closeApp,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    AppStrings.yes,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.no,
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: AppColor.greyBlueColor,
              title: const Text(AppStrings.wired, style: AppTextStyle.appBArTitle),
            ),
            body: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: userList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Text(AppStrings.somethingwentWrong);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(AppStrings.loading);
                    }

                    var dataItem = snapshot.data!.docs;

                    return Column(
                      children: [
                        SizedBox(
                            height: _screenHeight * 0.138,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dataItem.length,
                                itemBuilder: (context, index) {
                                  // Kindly comlete it
                                  if (dataItem[index][AppStrings.name] ==
                                      _auth.currentUser!.displayName) {
                                  }

                                  return Row(
                                    children: [
                                      // index == 0
                                      //     ? Text("${currentUser?[AppStrings.name]}")
                                      //     // StoryWidget(
                                      //     //     text: true,
                                      //     //     title: currentUser[AppStrings.name],
                                      //     //     imageUrl:
                                      //     //         currentUser[AppStrings.profilePic])
                                      //     : SizedBox.shrink(),
                                      StoryWidget(
                                          text: true,
                                          title: dataItem[index]
                                              [AppStrings.name],
                                          imageUrl: dataItem[index]
                                              [AppStrings.profilePic]),
                                    ],
                                  );
                                })),


                                
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: dataItem.length,
                            itemBuilder: (context, index) {
                              return NewsFeedWidget(
                                  titile: dataItem[index][AppStrings.name],
                                  url: dataItem[index][AppStrings.profilePic]);
                            })
                      ],
                    );
                  }),
            )),
      ),
    );
  }
}
