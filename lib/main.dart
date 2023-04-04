import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/screens/auth_screen.dart';
import 'package:firebase_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.redAccent,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.indigo,
              onPrimary: Colors.black,
              secondary: Colors.white12,
              onSecondary: Colors.white60,
              error: Colors.white12,
              onError: Colors.white60,
              background: Colors.pink,
              onBackground: Colors.pink,
              surface: Colors.white24,
              onSurface: Colors.white24)),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ChatScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}
