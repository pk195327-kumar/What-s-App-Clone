import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/models/user_models.dart';
import 'package:whats_app_me/common/utils/coloors.dart';
import 'package:whats_app_me/feature/contact/controllers/contacts_controller.dart';
import '../../../common/Wigets/custom_icon_button.dart';
import 'contactCard.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  shareSmsLink(phoneNumber) async {
    Uri sms = Uri.parse(
        "sms:$phoneNumber?body= Let's chat on whatsApp! it's a fast, simple, and secure app we call each other for free. get it at https://whatsappme.com/dl/");
    if (await launchUrl(sms)) {
    } else {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select contact",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 3,
            ),
            ref.watch(contactControllerProvider).when(
              data: (allContacts) {
                return Text(
                  "${allContacts[1].length} Contact${allContacts[1].length == 1 ? '' : 's'}",
                  style: TextStyle(fontSize: 13),
                );
              },
              error: (e, t) {
                return SizedBox();
              },
              loading: () {
                return const Text(
                  "Counting",
                  style: TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
        actions: [
          CustomIconButton(onTap: () {}, icon: Icons.search),
          CustomIconButton(onTap: () {}, icon: Icons.more_vert),
        ],
      ),
      body: ref.watch(contactControllerProvider).when(
        data: (allContacts) {
          return ListView.builder(
            itemCount: allContacts[0].length + allContacts[1].length,
            itemBuilder: (contaxt, Index) {
              late userModel firebaseContacts;
              late userModel phoneContacts;
              if (Index < allContacts[1].length) {
                firebaseContacts = allContacts[1][Index];
              } else {
                phoneContacts = allContacts[1][Index - allContacts[0].length];
              }
              print("PhoneContact: ${firebaseContacts.toMap()}");

              return Index < allContacts[1].length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (Index == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myListTile(
                                  leading: Icons.group, text: "New Group "),
                              myListTile(
                                  leading: Icons.contacts,
                                  text: "New Contacts",
                                  trailing: Icons.qr_code)
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "Contacts on WhatsApp",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: contaxt.theme.graycolor),
                          ),
                        ),
                        ContactCard(
                          contactSource: firebaseContacts,
                          onTap: () {
                            shareSmsLink(firebaseContacts.phoneNumber);
                          },
                        )
                      ],
                    )
                  : SizedBox();
            },
          );
        },
        error: (e, t) {
          return null;
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(
              color: context.theme.authAppbarTextColor,
            ),
          );
        },
      ),
    );
  }
}

ListTile myListTile(
    {required IconData leading, required String text, IconData? trailing}) {
  return ListTile(
    contentPadding: EdgeInsets.only(top: 10, left: 20, right: 10),
    leading: CircleAvatar(
      backgroundColor: coloors.greendark,
      child: Icon(
        leading,
        color: Colors.white,
      ),
    ),
    title: Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    trailing: Icon(trailing, color: coloors.graydark),
  );
}
