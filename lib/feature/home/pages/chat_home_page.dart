import 'package:flutter/material.dart';
import 'package:whats_app_me/common/routes/routes.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  navigateToContactPage(context) {
    Navigator.pushNamed(context, Routes.contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Chat Home Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToContactPage(context);
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
