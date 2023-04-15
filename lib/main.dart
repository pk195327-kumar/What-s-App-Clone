import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_me/common/Themes/dark_theme.dart';
import 'package:whats_app_me/common/Themes/light_Theme.dart';
import 'package:whats_app_me/feature/auth/Controller/auth_controller.dart';
import 'package:whats_app_me/feature/home/pages/chat_home_page.dart';
import 'package:whats_app_me/feature/home/pages/home_pages.dart';
import 'package:whats_app_me/feature/welcome/pages/welcome_pages.dart';
import 'common/routes/routes.dart';
import 'feature/auth/pages/verification_pages_.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Me',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: ref.watch(userInfoAuthProvider).when(
        data: (user) {
          FlutterNativeSplash.remove();
          if (user == null) return const HomePage();
          return const HomePage();
        },
        error: (error, trace) {
          return const Scaffold(
            body: Center(
              child: Text("Someting Wrong happend!"),
            ),
          );
        },
        loading: () {
          return const SizedBox();
        },
      ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return verificationPage(
      smsCodeId: 'verification',
      phoneNumber: 'phoneNumber',
    );
  }
}
