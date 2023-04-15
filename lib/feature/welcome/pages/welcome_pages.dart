import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/utils/coloors.dart';
import 'package:whats_app_me/feature/welcome/pages/widget/Privacy_And_Terms.dart';
import 'package:whats_app_me/feature/welcome/pages/widget/languageButton.dart';
import '../../../common/Wigets/custom_elevated_button.dart';
import '../../../common/routes/routes.dart';

class WelcomePages extends StatelessWidget {

  navigateToLoginPage(context){
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset(
              'Assets/circle.png',
              color: context.theme.circleimagecolor,
            ),
          ),
        )),
        SizedBox(
          height: 40,
        ),
        Expanded(
            child: Column(
          children: [
            Text(
              "Welcome to WhatsApp",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const PrivacyAndTerms(),
            Custom_ElevatedButton(
              onPressed: () => navigateToLoginPage(context),
              text: 'AGREE AND CONTINUE',
            ),
            const SizedBox(
              height: 50,
            ),
            languageButton()
          ],
        ))
      ],
    ));
  }
}
