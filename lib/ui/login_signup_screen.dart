import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_assets.dart';
import 'package:wired_social/utils/app_routes.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_style.dart';
import 'package:wired_social/widgets/text_button.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  bool _colourLogin = true;
  bool _colourSignUp = false;
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssetsImage.loginScreenBackgroundImage),
              fit: BoxFit.cover),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.5),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssetsImage.appLogo,
                height: _screenHeight * 0.12,
                width: 113,
              ),
              SizedBox(
                height: _screenHeight * 0.01,
              ),
              const Text(
                AppStrings.appName,
                style: AppTextStyle.wiredTextStyle,
              ),
              SizedBox(
                height: _screenHeight * 0.1,
              ),
              AppTextButton(
                  size: Size(_screenWidth * 0.72, _screenHeight * 0.054),
                  buttonColor: _colourLogin,
                  buttonString: AppStrings.login,
                  onPressed: () {
                    setState(() {
                      _colourLogin = true;
                      _colourSignUp = false;
                    });
                    Navigator.pushNamed(context, AppRoutes.topTabBar,
                        arguments: 0);
                  }),
              SizedBox(
                height: _screenHeight * 0.01,
              ),
              AppTextButton(
                  size: Size(_screenWidth * 0.72, _screenHeight * 0.054),
                  buttonColor: _colourSignUp,
                  buttonString: AppStrings.signUp,
                  onPressed: () async {
                    setState(() {
                      _colourSignUp = true;
                      _colourLogin = false;
                    });
                    await Future.delayed(const Duration(milliseconds: 60));
                    Navigator.pushNamed(context, AppRoutes.topTabBar,
                        arguments: 1);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
