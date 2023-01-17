import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wired_social/authentication/auth.dart';
import 'package:wired_social/provider/app_provider.dart';
import 'package:wired_social/utils/app_assets.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_style.dart';
import 'package:wired_social/utils/app_validator.dart';
import 'package:wired_social/widgets/text_button.dart';
import 'package:wired_social/widgets/text_formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late List<TextEditingController> _controllerList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool onpressed = false;
  bool value = false;
  bool _colour = false;
  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    _controllerList = [_emailTextController, _passwordTextController];
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    double _screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Consumer<AppProvider>(
          builder: (context, _appProvider, child) {
            return Form(
              key: _formKey,
              onChanged: () {
                _colour = _appProvider.onchanging(_controllerList);
              },
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  AppTextFormField(
                      validator: AppValidator().isEmailValidator,
                      labelText: AppStrings.userName,
                      icon: Image.asset(AppAssetsImage.userNameLogo),
                      controller: _emailTextController),
                  SizedBox(height: _screenHeight * 0.046),
                  AppTextFormField(
                      obscureText: value,
                      suffixIcon: IconButton(
                        splashRadius: 0.01,
                        splashColor: AppColor.whiteColor,
                        highlightColor: AppColor.whiteColor,
                        icon: value
                            ? const Icon(
                                Icons.visibility_rounded,
                                color: AppColor.greyColor,
                              )
                            : const Icon(
                                Icons.visibility_off_rounded,
                                color: AppColor.greyColor,
                              ),
                        onPressed: () {
                          value = _appProvider.ontoggle(value);
                        },
                      ),
                      validator: AppValidator().isPassWordValidator,
                      labelText: AppStrings.password,
                      icon: Image.asset(AppAssetsImage.passwordLogo),
                      controller: _passwordTextController),
                  SizedBox(height: _screenHeight * 0.019),
                  Center(
                    child: Text(
                      AppStrings.forgotPassword,
                      style: AppTextStyle.buttonTextStyle.copyWith(
                          color: AppColor.greyColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(height: _screenHeight * 0.06),
                  AppTextButton(
                      size: Size(_screenWidth * 0.07, _screenHeight * 0.07),
                      buttonColor: _colour,
                      transparent: false,
                      buttonString: AppStrings.login,
                      onPressed: _colour
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                               await AuthenticationUsingFireBase()
                                    .signInWithEmailAndPassword(
                                        context,
                                        _emailTextController.text,
                                        _passwordTextController.text);

                             
                              
                              }
                            }
                          : null),
                  SizedBox(height: _screenHeight * 0.0126),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        color: AppColor.greyColor,
                      )),
                      Text(
                        AppStrings.or,
                        style: AppTextStyle.buttonTextStyle
                            .copyWith(fontSize: 14, color: AppColor.greyColor),
                      ),
                      const Expanded(
                          child: Divider(
                        color: AppColor.greyColor,
                      )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      AuthenticationUsingFireBase().googleSignIn(context);
                    },
                    child: Image.asset(
                      AppAssetsImage.googleLogo,
                      height: 20,
                    ),
                  ),
                  Center(
                    child: Text(AppStrings.bySigningIn,
                        style: AppTextStyle.buttonTextStyle.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppColor.greyColor)),
                  ),
                  Center(
                    child: Text(AppStrings.youAgree,
                        style: AppTextStyle.buttonTextStyle.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: AppColor.greyColor)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Map<String,dynamic>checkUserList(Map<String ,dynamic> data){

//      for(int i=0;i<userUpdatedMap.length-1;i++){
//        if(mapEquals(userUpdatedMap[i], data)   ){
//          continue;

//        }
//        else{
//          return userUpdatedMap[i];

//        }

//      }
//      return data;
     
//    }
