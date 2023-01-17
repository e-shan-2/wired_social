// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:wired_social/services/shared_prefernces.dart';
// import 'package:wired_social/ui/bottom_tab_bar.dart';
// import 'package:wired_social/utils/app_string.dart';
// import 'package:wired_social/widgets/app_common_snackbar.dart';

// class AuthenticationUsingFireBase {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   FirebaseFirestore _fireStore = FirebaseFirestore.instance;

//   Future<void> signupUsingGoogle(BuildContext context) async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;
//         final AuthCredential authCredential = GoogleAuthProvider.credential(
//             idToken: googleSignInAuthentication.idToken,
//             accessToken: googleSignInAuthentication.accessToken);

//         // Getting users credential
//         UserCredential result =
//             await _auth.signInWithCredential(authCredential);

//         if (result != null) {
//           await _fireStore.collection('users').doc(_auth.currentUser!.uid);

//           AppCommonSnackBar().appCommonSnackbar(context, result.toString());
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => const BottomTabBar()));
//         }
//         AppCommonSnackBar().appCommonSnackbar(context, result.toString());
//       }
//     } on FirebaseAuthException catch (e) {
//       AppCommonSnackBar().appCommonSnackbar(context, e.toString());
//     } catch (e) {
//       AppCommonSnackBar().appCommonSnackbar(context, e.toString());
//       throw "$e";
//     }
//   }

//   Future<UserCredential?> signIn(
//       String email, String password, BuildContext context) async {
//     SharedPrefernceClass _localStorage = SharedPrefernceClass();
//     UserCredential? data;
//     try {
//       data = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);

//       // _localStorage.setUserId(data.user!.uid);

//       if (data != null) {
//         AppCommonSnackBar().appCommonSnackbar(context, data.toString());
//       }
//     } on FirebaseAuthException catch (e) {
//       AppCommonSnackBar().appCommonSnackbar(context, e.toString());
//     } catch (e) {
//       AppCommonSnackBar().appCommonSnackbar(context, e.toString());
//       throw "$e";
//     }
//     return data;
//   }

//   Future<UserCredential> register(
//       String name, String email, String password, BuildContext context) async {
//     try {
//       UserCredential data = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);

//       if (data != null) {
//         data.user!.updateDisplayName(name);
//         await _fireStore.collection('users').doc(_auth.currentUser!.uid).set({
//           "name": name,
//           "email": email,
//           "status": "unavailable",
//         });
//       }
//       AppCommonSnackBar().appCommonSnackbar(context, data.toString());
//       return data;
//     } on FirebaseAuthException catch (e) {
//       AppCommonSnackBar().appCommonSnackbar(context, e.toString());

//       throw "$e";
//     } catch (e) {
//       AppCommonSnackBar().appCommonSnackbar(context, e.toString());
//       throw "$e";
//     }
//   }

//   Future<void> signout(
//     BuildContext context,
//   ) async {
//     try {
//       await _auth.signOut();
//       AppCommonSnackBar().appCommonSnackbar(context, AppStrings.success);
//     } on FirebaseException catch (e) {
//       AppCommonSnackBar().appCommonSnackbar(context, e.toString());
//       throw "$e";
//     } catch (e) {
//       AppCommonSnackBar().appCommonSnackbar(context, e.toString());
//       throw "$e";
//     }
//   }
// }
// final SharedPrefernceClass _localStorage = SharedPrefernceClass();

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wired_social/services/shared_prefernces.dart';
import 'package:wired_social/utils/app_routes.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/widgets/app_common_snackbar.dart';

class AuthenticationUsingFireBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final SharedPrefernceClass _localStorage = SharedPrefernceClass();
  //Sign Up
  Future<void> signUpWithEmailAndPassword(
    BuildContext context,
    String name,
    String email,
    String password,
    String url,
  ) async {
    try {
      UserCredential userCrendetial = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCrendetial.user != null) {
        log(AppStrings.createdSuccessfully);
        userCrendetial.user!.updateDisplayName(name);

        if(url==""){
        await _firestore
            .collection(AppStrings.users)
            .doc(_firebaseAuth.currentUser!.uid)
            .set({
          AppStrings.name: name,
          AppStrings.email: email,
          AppStrings.uid: _firebaseAuth.currentUser!.uid,
          AppStrings.profilePic: url,
        });
        }
        AppCommonSnackBar().appCommonSnackbar(context, AppStrings.success);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.bottomTabBar, (route) => false);
      } else {}
    } on FirebaseAuthException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, e.message!);
      // return e as User;
    }
  }

  //Sign In
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // log();

      // ignore: unnecessary_null_comparison

      _firestore
          .collection(AppStrings.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .get()
          .then((value) =>
              userCredential.user!.updateDisplayName(value[AppStrings.name]));
      AppCommonSnackBar().appCommonSnackbar(context, AppStrings.success);

      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.bottomTabBar, (route) => false);
    } on FirebaseAuthException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, e.message!);
      log(e.toString());
    }
  }

  //Sign Out
  Future logOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      AppCommonSnackBar().appCommonSnackbar(context, AppStrings.success);
      Navigator.pushNamed(context, AppRoutes.loginSignupScreen);
    } on FirebaseAuthException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, e.message!);
      log(e.toString());
    }
  }

  //Google Sign In
  Future<GoogleSignInAccount> googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    try {
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(authCredential);
        final User? user = userCredential.user;
        assert(user!.displayName != null);
        assert(user!.email != null);

        final User? currentUser = _firebaseAuth.currentUser;
        assert(currentUser!.uid == user!.uid);
        _localStorage.setUserId(AppStrings.googleSignIn, "1");
        AppCommonSnackBar().appCommonSnackbar(context, AppStrings.success);

        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.bottomTabBar, (route) => false);
      } else {
        AppCommonSnackBar()
            .appCommonSnackbar(context, AppStrings.somethingwentWrong);
      }
    } catch (e) {
      AppCommonSnackBar()
          .appCommonSnackbar(context, AppStrings.somethingwentWrong);
      throw AppStrings.errorSignIn;
    }
    return googleSignInAccount!;
  }

  //Google Sign Out
  Future<void> googleSignOut(BuildContext context) async {
    try {
      var x = await _googleSignIn.signOut();
      String response = x.toString();
      if (response == AppStrings.loginSuccess) {
        AppCommonSnackBar().appCommonSnackbar(context, response);

        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.loginSignupScreen, (route) => false);
      } else {
        AppCommonSnackBar().appCommonSnackbar(context, response);
      }
    } on FirebaseAuthException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, e.message!);
    }
    // await logOut();
  }
}

// ignore_for_file: use_build_context_synchronously


/*
class AuthenticationUsingFireBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final SharedPrefernceClass _localStorage = SharedPrefernceClass();
  //Sign Up
  Future<ResponseModel?> signUpWithEmailAndPassword(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required String profilePic}) async {
    try {
      UserCredential userCrendetial = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCrendetial.user != null) {
        userCrendetial.user!.updateDisplayName(name);
        userCrendetial.user!.updatePhotoURL(profilePic);
        userCrendetial.user!.updateEmail(email);
        userCrendetial.user!.updatePassword(password);

        await _firestore
            .collection(AppStrings.users)
            .doc(_firebaseAuth.currentUser!.uid)
            .set({
          AppStrings.name: name,
          AppStrings.email: email,
          AppStrings.uid: _firebaseAuth.currentUser!.uid,
          AppStrings.profilePic: profilePic,
        });
        return ResponseModel(user: userCrendetial.user);
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      String? error;
      if (e.message == AppStrings.emailAlreadyInUse) {
        error = e.message;
      }
      return ResponseModel(error: error);
    }
    return ResponseModel(error: AppStrings.unknownError);
  }

  //Sign In
  Future signInWithEmailAndPassword(
      {required BuildContext context,required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // log(AppStrings.loginSuccess);
      _firestore
          .collection(AppStrings.users)
          .doc(_firebaseAuth.currentUser!.uid)
          .get()
          .then(
            (value) =>
                userCredential.user!.updateDisplayName(value[AppStrings.name]),
          );

      return userCredential;
    } catch (e) {
      // log(e.toString());
      return null;
    }
  }

  Future forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // log(e.toString());
      return null;
    }
  }

  //Sign Out
  Future logOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.loginSignupScreen, (route) => false);
    } catch (e) {
      // log(e.toString());
    }
  }

  //Google Sign Out
  Future<void> googleSignOut(BuildContext context) async {
    var x = await _googleSignIn.signOut();

    await logOut(context);
    log(x.toString());
  }



  // Google Sign In
  Future<GoogleSignInAccount> googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    try {
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(authCredential);
        final User? user = userCredential.user;
        assert(user!.displayName != null);
        assert(user!.email != null);

        final User? currentUser = _firebaseAuth.currentUser;
        assert(currentUser!.uid == user!.uid);
        _localStorage.setUserId(AppStrings.googleSignIn, "1");
        AppCommonSnackBar().appCommonSnackbar(context, AppStrings.success);

        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.bottomTabBar, (route) => false);
      } else {
        AppCommonSnackBar()
            .appCommonSnackbar(context, AppStrings.somethingwentWrong);
      }
    } catch (e) {
      AppCommonSnackBar()
          .appCommonSnackbar(context, AppStrings.somethingwentWrong);
      throw AppStrings.errorSignIn;
    }
    return googleSignInAccount!;
  }



}
*/
