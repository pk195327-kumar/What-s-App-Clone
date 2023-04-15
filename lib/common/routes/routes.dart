import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_me/common/models/user_models.dart';
import 'package:whats_app_me/feature/auth/pages/login_page.dart';
import 'package:whats_app_me/feature/auth/pages/verification_pages_.dart';
import 'package:whats_app_me/feature/chat/pages/chat_page.dart';
import 'package:whats_app_me/feature/home/pages/home_pages.dart';
import 'package:whats_app_me/feature/welcome/pages/welcome_pages.dart';

import '../../feature/auth/pages/user_Info_page.dart';
import '../../feature/contact/pages/contact_page.dart';

class Routes {
  static const String Welcome = 'Welcome';
  static const String verification = 'verification';
  static const String login = 'login';
  static const String userInfo = 'user-info';
  static const String home = 'home';
  static const String contact = 'contact';
  static const String Chat = 'Chat';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Welcome:
        return MaterialPageRoute(
          builder: (context) => WelcomePages(),
        );

      case login:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );

      case verification:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => verificationPage(
            smsCodeId: args['smsCodeId'],
            phoneNumber: args["phoneNumber"],
          ),
        );

      case userInfo:
        final String? profileImageUrl = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => UserInfoPage(
            profileImageUrl: profileImageUrl,
          ),
        );

      case home:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );

      case contact:
        return MaterialPageRoute(
          builder: (context) => ContactPage(),
        );
      case Chat:
        final userModel user = settings.arguments as userModel;
        return MaterialPageRoute(
          builder: (context) => ChatPage(
            user: user,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No Page Route Provided'),
            ),
          ),
        );
    }
  }
}
