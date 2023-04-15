import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/models/user_models.dart';
import 'package:whats_app_me/common/utils/coloors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {Key? key, required this.contactSource, required this.onTap})
      : super(key: key);

  final userModel contactSource;
  final VoidCallback onTap;

  shareSmsLink(phoneNumber) async {
    Uri sms = Uri.parse(
        "sms:$phoneNumber?body= Let's chat on whatsApp! it's a fast, simple, and secure app we call each other for free. get it at https://whatsappme.com/dl/");
    if (await launchUrl(sms)) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(
        left: 20,
        right: 10,
      ),
      leading: CircleAvatar(
        backgroundColor: context.theme.graycolor!.withOpacity(0.3),
        radius: 20,
        backgroundImage: contactSource.profileImageUrl.isNotEmpty
            ? NetworkImage(contactSource.profileImageUrl)
            : null,
        child: contactSource.profileImageUrl.isEmpty
            ? const Icon(Icons.person, size: 30, color: Colors.white)
            : null,
      ),
      title: Text(
        contactSource.username,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: contactSource.profileImageUrl.isEmpty
          ? TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(foregroundColor: coloors.greendark),
              child: const Text("INVITE"),
            )
          : null,
    );
  }
}
