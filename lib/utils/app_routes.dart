import 'package:flutter/material.dart';
import 'package:wired_social/ui/bottom_tab_bar.dart';
import 'package:wired_social/ui/chat_screen.dart';
import 'package:wired_social/ui/edit_screen.dart';
import 'package:wired_social/ui/full_chat_list.dart';
import 'package:wired_social/ui/group_chat.dart';
import 'package:wired_social/ui/login_screen.dart';
import 'package:wired_social/ui/signup_screen.dart';
import 'package:wired_social/ui/top_tabbar.dart';
import 'package:wired_social/ui/error_page.dart';
import 'package:wired_social/ui/login_signup_screen.dart';

class AppRoutes {
  static const loginSignupScreen = "/";
  static const topTabBar = "/topTabBar";
  static const loginpageRoute = "/loginPageRoute";
  static const signupPageRoute = "/signupPageRoute";
  static const bottomTabBar = "/bottomTabBar";
  static const chatui = "/chatui";
  static const fullChatList = "/fullscreen";
  static const editProfile = "/editProfile";
  static const groupChat = "/groupChat";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginSignupScreen:
        return MaterialPageRoute(
            builder: ((context) => const LoginSignUpScreen()));
      case topTabBar:
        return MaterialPageRoute(
            builder: ((context) => TopTabBAr(
                  choose: settings.arguments as int,
                )));
      case loginpageRoute:
        return MaterialPageRoute(builder: ((context) => const LoginScreen()));
      case signupPageRoute:
        return MaterialPageRoute(builder: ((context) => const SignUpScreen()));
      case bottomTabBar:
        return MaterialPageRoute(builder: ((context) => const BottomTabBar()));
      case chatui:
        return MaterialPageRoute(
            builder: ((context) => ChatScreenUi(
                // userMap: settings.arguments as Map<String, dynamic>,
                chatRoomId: settings.arguments as String,
                userList: settings.arguments as List<String>)));

      case fullChatList:
        return MaterialPageRoute(builder: ((context) => const FullChatList()));
      case editProfile:
        return MaterialPageRoute(builder: ((context) => const EditProfile()));

      case groupChat:
        return MaterialPageRoute(builder: ((context) => const GroupChat()));

      default:
        return MaterialPageRoute(builder: ((context) => const ErrorPage()));
    }
  }
}

 //  return MaterialPageRoute(
    //       builder: (context) => ChangeNotifierProvider(
    //         create: (context) => ChatProvider(),
    //         child: const LoginScreen(),
    //       ),
    //     );
