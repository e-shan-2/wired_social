import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wired_social/firebase_options.dart';
import 'package:wired_social/provider/app_provider.dart';
import 'package:wired_social/provider/chat_provider.dart';
import 'package:wired_social/provider/file_provider.dart';
import 'package:wired_social/utils/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WiredSocial());
}

class WiredSocial extends StatefulWidget {
  const WiredSocial({Key? key}) : super(key: key);

  @override
  State<WiredSocial> createState() => _WiredSocialState();
}

class _WiredSocialState extends State<WiredSocial> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FileProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: _auth.currentUser != null
            ? AppRoutes.bottomTabBar
            : AppRoutes.loginSignupScreen,
      ),
    );
  }
}
