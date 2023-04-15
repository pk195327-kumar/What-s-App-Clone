import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app_me/common/Wigets/custom_elevated_button.dart';
import 'package:whats_app_me/common/Wigets/custom_icon_button.dart';
import 'package:whats_app_me/common/Wigets/short_h_bar.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/helper/show_alert_dialog.dart';
import 'package:whats_app_me/common/utils/coloors.dart';
import 'package:whats_app_me/feature/auth/Controller/auth_controller.dart';
import 'package:whats_app_me/feature/auth/Widgets/custom_text_filed.dart';
import 'package:whats_app_me/feature/auth/pages/image_picker_pages.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({Key? key, this.profileImageUrl}) : super(key: key);

  final String? profileImageUrl;

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController usernameController;

  saveUserDataToFirbase() {
    String username = usernameController.text;

    if (username.isEmpty) {
      return showAlertDialog(
          context: context, Message: "Please Provide Username");
    } else if (username.length < 3 || username.length > 20) {
      return showAlertDialog(
          context: context,
          Message: "A Username length should be between 3-20");
    }
    ref.read(authControllerProvider).saveUserInfoTofirbase(
        username: username,
        profileImage:
            imageCamera ?? imageGallery ?? widget.profileImageUrl ?? "",
        context: context,
        mounted: mounted);
  }

  imagePickerTypeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShortHBar(),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Profile photo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                CustomIconButton(
                    onTap: () => Navigator.pop(context), icon: Icons.close),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            Divider(
              color: context.theme.graycolor!.withOpacity(0.3),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                imagePickerIcon(
                  ontap: pickImageFromCamera,
                  icon: Icons.camera_alt_rounded,
                  text: 'Camera',
                ),
                SizedBox(
                  width: 15,
                ),
                imagePickerIcon(
                  ontap: () async {
                    Navigator.pop(context);
                    final image = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => imagepickerpage(),
                      ),
                    );
                    if (image == null) return;
                    setState(() {
                      imageGallery = image;
                      imageCamera = null;
                    });
                  },
                  icon: Icons.photo_camera_back_rounded,
                  text: 'Gallery',
                ),
              ],
            ),
            SizedBox(
              height: 15,
            )
          ],
        );
      },
    );
  }

  void pickImageFromCamera() async {
    Navigator.of(context).pop();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, Message: e.toString());
    }
  }

  imagePickerIcon({
    required Function ontap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onTap: () {
            ontap();
          },
          icon: icon,
          iconColor: coloors.greendark,
          minWidth: 50,
          border: Border.all(
            color: context.theme.graycolor!.withOpacity(.2),
            width: 1,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: context.theme.graycolor),
        ),
      ],
    );
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile Info",
          style: TextStyle(color: context.theme.authAppbarTextColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              "please provide your name and an optional profile photo",
              style: TextStyle(color: context.theme.graycolor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                imagePickerTypeBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.all(26),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.photoIconBgColor,
                    border: Border.all(
                      color: imageCamera == null && imageGallery == null
                          ? Colors.transparent
                          : context.theme.graycolor!.withOpacity(0.4),
                    ),
                    image: imageCamera != null ||
                            imageGallery != null ||
                            widget.profileImageUrl != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: imageGallery != null
                                ? MemoryImage(imageGallery!) as ImageProvider
                                : widget.profileImageUrl != null
                                    ? NetworkImage(widget.profileImageUrl!)
                                    : FileImage(imageCamera!) as ImageProvider,
                          )
                        : null),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 3,
                    right: 3,
                  ),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: imageCamera == null &&
                            imageGallery == null &&
                            widget.profileImageUrl == null
                        ? context.theme.phototIconColor
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomTextFiled(
                    controller: usernameController,
                    hintText: 'Type your name here',
                    textAlign: TextAlign.left,
                    autoFocus: true,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.emoji_emotions_outlined,
                    color: context.theme.phototIconColor),
                SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Custom_ElevatedButton(
        onPressed: () {
          saveUserDataToFirbase();
        },
        text: 'NEXT',
        buttonwidth: 90,
      ),
    );
  }
}
