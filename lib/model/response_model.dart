import 'package:firebase_auth/firebase_auth.dart';

class ResponseModel {
  User? user;
  String? error;

  ResponseModel({
    this.user,
    this.error,
  });
}