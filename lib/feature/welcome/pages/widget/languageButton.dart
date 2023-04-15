import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whats_app_me/common/Wigets/custom_icon_button.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/utils/coloors.dart';

class languageButton extends StatelessWidget {
  const languageButton({Key? key}) : super(key: key);
  showBottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                    color: context.theme.graycolor?.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CustomIconButton(
                      onTap: () => Navigator.of(context).pop(),
                      icon: Icons.close_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "App Language",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Divider(
                color: context.theme.graycolor?.withOpacity(0.3),
                thickness: .5,
              ),
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: ((value) {}),
                activeColor: coloors.greendark,
                title: Text("English"),
                subtitle: Text(
                  "(Phone's language)",
                  style: TextStyle(color: context.theme.graycolor),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: false,
                onChanged: ((value) {}),
                activeColor: coloors.greendark,
                title: Text("Hindi"),
                subtitle: Text(
                  "(Phone's language)",
                  style: TextStyle(color: context.theme.graycolor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.langBtnBgcolor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.theme.langBtnHighlightcolor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                color: coloors.greendark,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "English",
                style: TextStyle(color: coloors.greendark),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: coloors.greendark,
              )
            ],
          ),
        ),
      ),
    );
  }
}
