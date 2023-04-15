import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whats_app_me/common/helper/show_alert_dialog.dart';
import 'package:whats_app_me/common/helper/show_loding_dialog.dart';
import 'package:whats_app_me/common/models/user_models.dart';
import 'package:whats_app_me/common/repositroy/firebase_storage_repositroy.dart';
import 'package:whats_app_me/common/routes/routes.dart';

final authRepositroyProvider = Provider((ref) {
  return AuthRepositroy(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});

class AuthRepositroy {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepositroy({
    required this.auth,
    required this.firestore,
  });

  Future<userModel?> getCurrentUserInfo() async {
    userModel? user;
    final UserInfo =
        await firestore.collection('Users').doc(auth.currentUser?.uid).get();
    if (UserInfo.data() == null) return user;
    user = userModel.fromMap(UserInfo.data()!);
    return user;
  }

  void saveUserInfoTofirbase({
    required String username,
    required var profileImage,
    required ProviderRef ref,
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      showLodingDialog(context: context, message: "Saving user info ...");
      String uid = auth.currentUser!.uid;
      String profileImageUrl = profileImage is String ? profileImage : "";
      if (profileImage != null && profileImage is! String) {
        profileImageUrl = await ref
            .read(firebaseStorageRepositroyProvider)
            .storeFileToFirebase("profileImage$uid", profileImage);
      }
      userModel user = userModel(
        username: username,
        uid: uid,
        profileImageUrl: profileImageUrl,
        active: true,
        phoneNumber: auth.currentUser!.phoneNumber!,
        groupId: [],
      );

      await firestore.collection("users").doc(uid).set(user.toMap());
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (route) => false,
      );
    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, Message: e.toString());
    }
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      showLodingDialog(context: context, message: "verifiying code ...");
      final credenial = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credenial);
      userModel? user = await getCurrentUserInfo();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.userInfo,
        (route) => false,
        arguments: user?.profileImageUrl,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, Message: e.toString());
    }
  }

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      showLodingDialog(
          context: context,
          message: "Sending a Verification code to $phoneNumber");
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showAlertDialog(context: context, Message: e.toString());
        },
        codeSent: (smsCodeId, resendSmsCodeId) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.verification, (route) => false,
              arguments: {
                "phoneNumber": phoneNumber,
                "smsCodeId": smsCodeId,
              });
        },
        codeAutoRetrievalTimeout: (String smsCodeId) {},
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, Message: e.toString());
    } catch (e) {
      showAlertDialog(context: context, Message: "Error");
    }
  }
}
