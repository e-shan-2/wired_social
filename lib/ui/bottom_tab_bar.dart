import 'package:flutter/material.dart';
import 'package:wired_social/ui/home_page.dart';
import 'package:wired_social/ui/message.dart';
import 'package:wired_social/ui/notification.dart';
import 'package:wired_social/ui/settings.dart';
import 'package:wired_social/utils/app_colour.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late int _totoalNotifications;
  // late final FirebaseMessaging _messaging;
  // PushNotification? _notificationInfo;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  // void registerNotification() async {
  //   // 1. Initialize the Firebase app
  //   // await Firebase.initializeApp();

  //   // 2. Instantiate Firebase Messaging
  //   _messaging = FirebaseMessaging.instance;

  //   // 3. On iOS, this helps to take the user permissions
  //   NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //

  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       if (_notificationInfo != null) {}
  //       PushNotification notification = PushNotification(
  //         title: message.notification?.title,
  //         body: message.notification?.body,
  //       );
  //       showSimpleNotification(
  //         Text(_notificationInfo!.title!),
  //         leading: NotificationBadge(totalNotifications: _totoalNotifications),
  //         subtitle: Text(_notificationInfo!.body!),
  //         background: Colors.cyan.shade700,
  //         duration: Duration(seconds: 2),
  //       );

  //       setState(() {
  //         _notificationInfo = notification;
  //         _totoalNotifications++;
  //       });
  //     });
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // double _screenHeight = MediaQuery.of(context).size.height;

    // double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: TabBarView(controller: _tabController, children: const [
        HomePage(),
        MessageScreen(),
        NotificationScreen(),
        SettingsScreen(),
      ]),
      bottomNavigationBar: menu(),
    );
  }

  Widget menu() {
    return Container(
      color: AppColor.whiteColor,
      child: TabBar(
          controller: _tabController,
          unselectedLabelColor: AppColor.greyColor,
          labelColor: AppColor.greyBlueColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.transparent,
          tabs: const [
            Tab(
              child: Icon(
                Icons.home_filled,
              ),
            ),
            Tab(
              child: Icon(Icons.message),
            ),
            Tab(
              child: Icon(Icons.notification_add),
            ),
            Tab(child: Icon(Icons.settings)),
          ]),
    );
  }
}
