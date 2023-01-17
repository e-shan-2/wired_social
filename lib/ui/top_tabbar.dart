import 'package:flutter/material.dart';
import 'package:wired_social/ui/login_screen.dart';
import 'package:wired_social/ui/signup_screen.dart';
import 'package:wired_social/utils/app_assets.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_style.dart';

// ignore: must_be_immutable
class TopTabBAr extends StatefulWidget {
  int choose;
  TopTabBAr({required this.choose, Key? key}) : super(key: key);

  @override
  State<TopTabBAr> createState() => _TopTabBArState();
}

class _TopTabBArState extends State<TopTabBAr>
    with SingleTickerProviderStateMixin {
  // static const List<Tab> _screenTab = <Tab>[
  //   Tab(child: LoginScreen()),
  //   Tab(child: SignUpScreen()),
  // ];
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.index = widget.choose;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    // double _screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: _screenHeight * 0.2,
            backgroundColor: AppColor.whiteColor,
            centerTitle: true,
            title: Column(
              children: [
                Image.asset(AppAssetsImage.applLogoCircualar),
                SizedBox(
                  height: _screenHeight * 0.025,
                ),
                Text(AppStrings.appName,
                    style: AppTextStyle.wiredTextStyle
                        .copyWith(color: AppColor.greyBlueColor))
              ],
            ),
          ),
          body: Column(
            children: [
              menu(),
              Expanded(
                  child: TabBarView(controller: _controller, children: const [
                LoginScreen(),
                SignUpScreen(),
              ])),
            ],
          )),
    );
  }

  Widget menu() {
    return Container(
      color: AppColor.whiteColor,
      child: TabBar(
        controller: _controller,
        unselectedLabelColor: AppColor.greyColor,
        labelColor: AppColor.gradientColour,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.transparent,
        tabs: const [
          Text(AppStrings.login, style: AppTextStyle.loginSignupTabBar),
          Text(AppStrings.signUp, style: AppTextStyle.loginSignupTabBar)
        ],
      ),
    );
  }
}
