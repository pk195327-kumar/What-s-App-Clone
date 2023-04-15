import 'package:flutter/material.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';

showAlertDialog({
  required BuildContext context,
  required String Message,
  String? btnText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            Message,
            style: TextStyle(color: context.theme.graycolor, fontSize: 15),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                btnText ?? 'OK',
                style: TextStyle(color: context.theme.circleimagecolor),
              ),
            )
          ],
        );
      },);
}
