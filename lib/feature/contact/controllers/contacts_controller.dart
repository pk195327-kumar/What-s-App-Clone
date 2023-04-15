import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_me/feature/contact/repositry/contact_repositry.dart';

final contactControllerProvider = FutureProvider((ref) {
  final contactRepositry = ref.watch(contactsRepositryProvider);
  return contactRepositry.getAllContacts();
});
