import 'package:flutter/material.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/utils/coloors.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Read our ',
              style: TextStyle(color: context.theme.graycolor, height: 1.5),
              children: [
                TextSpan(
                    text: 'Privacy poliey ',
                    style: TextStyle(color: context.theme.bluecolor)),
                const TextSpan(text: 'Tap "Agree and continue" accapt the '),
                TextSpan(
                    text: 'Terms of services.',
                    style: TextStyle(color: context.theme.bluecolor))
              ])),
    );
  }
}
