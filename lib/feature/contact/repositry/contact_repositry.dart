import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_me/common/models/user_models.dart';

final contactsRepositryProvider = Provider((ref) {
  return ContactsRepositry(firestore: FirebaseFirestore.instance);
});

class ContactsRepositry {
  final FirebaseFirestore firestore;

  ContactsRepositry({required this.firestore});

  Future<List<List>> getAllContacts () async {
    // These are contacts that are saved in the user's phone and have an account
    List<userModel> firebaseContacts = [];
    // These are contacts that are saved in the user's phone and does not have an account
    List<userModel> phoneContacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('users').get();
        final allContactsInThePhone = await FlutterContacts.getContacts(
          withProperties: true,
        );

        bool isContactFound = false;

        for (var contact in allContactsInThePhone) {
          for (var firebaseContactData in userCollection.docs) {
            var firebaseContact = userModel.fromMap(firebaseContactData.data());
            if (contact.phones[0].number.replaceAll("  ", " ") ==
                firebaseContact.phoneNumber) {
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
          }
          if (!isContactFound) {
            phoneContacts.add(
              userModel(
                username: contact.displayName,
                uid: "",
                profileImageUrl: "",
                active: false,
                phoneNumber: contact.phones[0].number.replaceAll("", ""),
                groupId: [],
              ),
            );
          }
          isContactFound = false;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return [firebaseContacts, phoneContacts];
  }
}
