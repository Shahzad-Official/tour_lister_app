import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tour_lister_app/services/get_user_data.dart';
import 'package:tour_lister_app/utils/app_snackbar.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';
import 'package:tour_lister_app/views/register/login.dart';
import 'package:tour_lister_app/views/register/sign_up.dart';

class LoginService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GetUserData _userData = GetUserData();

  doesContainId(uId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        AppSnackbar.snackBar(
            title: "Message", message: "User not available! SignUp first");
        _googleSignIn.signOut();
        Get.offAll(() => const SignUp());
      } else {
        await _userData.getUserData(uId);

        if (_userData.userProfile.uid == null) {
          AppSnackbar.snackBar(
              title: "Message", message: "User not available! SignUp first");
          _googleSignIn.signOut();
          Get.offAll(() => const SignUp());
        } else if (_userData.userProfile.uid == uId &&
            _userData.userProfile.role == "user") {
          AppSnackbar.snackBar(
              title: "Error",
              message: "This account is already registered on User App!");
          _googleSignIn.signOut();
          Get.offAll(() => const Login());
          return true;
        } else if (_userData.userProfile.uid == uId &&
            _userData.userProfile.role == "lister") {
          AppSnackbar.snackBar(
              title: "Message", message: "Successfully LogedIn");
          Get.offAll(() => MainPage());
          return true;
        }
      }
    });
  }

  static loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppSnackbar.snackBar(title: "Message", message: "Successfully LogedIn");
      Get.offAll(() => MainPage());
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  googleSignInService() async {
    try {
      var googleSignInAccount = await _googleSignIn.signIn();
      var googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var user = await _firebaseAuth.signInWithCredential(credential);
      var userId = user.user!.uid;
      doesContainId(userId);
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  faceBookLoginService() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      var user =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      var userId = user.user!.uid;
      doesContainId(userId);
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }
}
