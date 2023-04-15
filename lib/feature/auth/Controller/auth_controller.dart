import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_me/common/models/user_models.dart';
import 'package:whats_app_me/feature/auth/repositroy/auth_repositroy.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepositroy = ref.watch(authRepositroyProvider);
    return AuthController(
      authRepositroy: authRepositroy,
      ref: ref,
    );
  },
);

final userInfoAuthProvider = FutureProvider(
  ((ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getCurrntUserInfo();
  }),
);

class AuthController {
  final AuthRepositroy authRepositroy;
  final ProviderRef ref;

  AuthController({required this.authRepositroy, required this.ref});

  Future<userModel?> getCurrntUserInfo() async {
    userModel? User = await authRepositroy.getCurrentUserInfo();
    return User;
  }

  void saveUserInfoTofirbase({
    required String username,
    required var profileImage,
    required BuildContext context,
    required bool mounted,
  }) {
    authRepositroy.saveUserInfoTofirbase(
      username: username,
      profileImage: profileImage,
      ref: ref,
      context: context,
      mounted: mounted,
    );
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) {
    authRepositroy.verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sendSmsCode({
    required BuildContext context,
    required String PhoneNumber,
  }) async {
    authRepositroy.sendSmsCode(context: context, phoneNumber: PhoneNumber);
  }
}
