import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wired_social/authentication/auth.dart';
import 'package:wired_social/services/shared_prefernces.dart';
import 'package:wired_social/utils/app_assets.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_routes.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/widgets/list_tile.dart';
import 'package:wired_social/widgets/row_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, dynamic> userMap = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> userList =
        FirebaseFirestore.instance.collection(AppStrings.users).snapshots();
    FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPrefernceClass _localStorage = SharedPrefernceClass();

    double _screenHeight = MediaQuery.of(context).size.height;

    // double _screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushNamed(context, AppRoutes.bottomTabBar,
            arguments: 1);

        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.whiteColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _screenHeight * 0.02,
                  ),
                  SizedBox(
                    height: _screenHeight * 0.12,
                    child: StreamBuilder<Object>(
                        stream: userList,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return const Text(AppStrings.somethingwentWrong);
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(AppStrings.loading);
                          }

                          var dataItem = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: dataItem.length,
                            itemBuilder: ((context, index) {
                              if (dataItem[index][AppStrings.email] ==
                                  _auth.currentUser!.email) {
                                return ListTileMessageClass(
                                    networkImage: dataItem[index]
                                        [AppStrings.profilePic],
                                    title: "${_auth.currentUser!.displayName}",
                                    subTitile: "${_auth.currentUser!.email}");
                              }
                              return Container();
                            }),
                          );
                        }),
                  ),
                  const Divider(),
                  SizedBox(
                    height: _screenHeight * 0.03,
                  ),
                  SettingsRow(
                    onTap: () {},
                    title: "${_auth.currentUser!.email}",
                    image: AppAssetsImage.emailLogo,
                  ),
                  SizedBox(
                    height: _screenHeight * 0.03,
                  ),
                  SettingsRow(
                    title: AppStrings.followandInviteFriends,
                    image: AppAssetsImage.addpersonLogo,
                    onTap: () {
                      Navigator.popAndPushNamed(context, AppRoutes.editProfile);
                    },
                  ),
                  SizedBox(
                    height: _screenHeight * 0.025,
                  ),
                  SettingsRow(
                    title: AppStrings.notification,
                    image: AppAssetsImage.notificationLogo,
                  ),
                  SizedBox(
                    height: _screenHeight * 0.025,
                  ),
                  SettingsRow(
                    title: AppStrings.privacy,
                    image: AppAssetsImage.privacyLogo,
                  ),
                  SizedBox(
                    height: _screenHeight * 0.025,
                  ),
                  SettingsRow(
                    title: AppStrings.security,
                    image: AppAssetsImage.securityLogo,
                  ),
                  SizedBox(
                    height: _screenHeight * 0.025,
                  ),
                  SettingsRow(
                    title: AppStrings.theme,
                    image: AppAssetsImage.themeLogo,
                  ),
                  SizedBox(
                    height: _screenHeight * 0.025,
                  ),
                  SettingsRow(
                    title: AppStrings.help,
                    image: AppAssetsImage.helpLogo,
                  ),
                  SizedBox(
                    height: _screenHeight * 0.025,
                  ),
                  SettingsRow(
                    title: AppStrings.account,
                    image: AppAssetsImage.accountLogo,
                  ),
                  SizedBox(
                    height: _screenHeight * 0.025,
                  ),
                  SettingsRow(
                    title: AppStrings.about,
                    image: AppAssetsImage.aboutLogo,
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: AppColor.greyColor,
                  ),
                  SettingsRow(
                    onTap: () async {
                      String? data = await _localStorage
                          .getUserId(AppStrings.googleSignIn);

                      if (data == "1") {
                        await AuthenticationUsingFireBase()
                            .googleSignOut(context);
                      } else {
                        await AuthenticationUsingFireBase().logOut(context);
                      }
                    },
                    value: true,
                    title: AppStrings.logOut,
                    image: AppAssetsImage.logOutLogo,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
