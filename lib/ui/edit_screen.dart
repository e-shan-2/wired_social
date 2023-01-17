import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wired_social/provider/app_provider.dart';
import 'package:wired_social/utils/app_assets.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_validator.dart';
import 'package:wired_social/widgets/app_common_snackbar.dart';
import 'package:wired_social/widgets/file_picker.dart';
import 'package:wired_social/widgets/file_picker_class.dart';
import 'package:wired_social/widgets/text_button.dart';
import 'package:wired_social/widgets/text_formfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late List<TextEditingController> _controllerList;
  String? url;
  bool value = false;
  bool _colour = false;
  ImageProvider<Object>? profileImage;
  // const NetworkImage("https://picsum.photos/200/300/?blur");
  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _controllerList = [_nameController, _emailController, _passwordController];

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AppProvider>(
        builder: (context, _appProvider, _) {
          return Form(
            key: _formKey,
            onChanged: () {
              _colour = _appProvider.onchanging(_controllerList);
            },
            child: ListView(padding: const EdgeInsets.all(16.0), children: [
              CircleAvatar(
                radius: 37.5,
                backgroundImage: profileImage,
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_enhance_sharp,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ImagePickerClass(
                            onPressedGallery: () async {
                              url = await PickerMehthod()
                                  .imageFromGallery(context);
                              print(url);

                              if (url != null) {
                                setState(() {
                                  profileImage = NetworkImage(url!);
                                });
                              }

                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextFormField(
                  validator: AppValidator().isNameValidator,
                  labelText: AppStrings.yourName,
                  icon: Image.asset(AppAssetsImage.userNameLogo),
                  controller: _nameController),
              SizedBox(height: _screenHeight * 0.046),
              AppTextFormField(
                  validator: AppValidator().isEmailValidator,
                  labelText: AppStrings.yourEmail,
                  icon: Image.asset(AppAssetsImage.emailLogo),
                  controller: _emailController),
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
                  controller: _passwordController),
              SizedBox(height: _screenHeight * 0.08),
              AppTextButton(
                buttonColor: _colour,
                transparent: false,
                buttonString: AppStrings.signUp,
                onPressed: _colour
                    ? () {
                        if (url != null) {
                          if (_formKey.currentState!.validate()) {
                            try {
                              // AuthenticationUsingFireBase()
                              //     .signUpWithEmailAndPassword(
                              //   context,
                              //   _nameController.text,
                              //   _emailController.text,
                              //   _passwordController.text,
                              //   url!,
                              // );
                            } catch (e) {
                              throw "$e";
                            }
                          }
                        } else {
                          AppCommonSnackBar().appCommonSnackbar(
                              context, AppStrings.imageIsRequired);
                        }
                      }
                    : null,
                size: Size(_screenWidth * 0.9, _screenHeight * 0.07),
              )
            ]),
          );
        },
      ),
    );
  }
}
