import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/utils/coloors.dart';

showLodingDialog({
  required BuildContext context,
  required String message,
}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircularProgressIndicator(
                    color: coloors.greendark,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                          fontSize: 15,
                          color: context.theme.graycolor,
                          height: 1.5),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      });
}
