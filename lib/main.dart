import 'package:flutter/material.dart';
import 'package:text_me/Actions/chat_screen.dart';
import 'package:text_me/Actions/home_chat_screen.dart';
import 'package:text_me/Auth/welcome_page.dart';
import 'package:text_me/Auth/login_screen.dart';
import 'package:text_me/Auth/signup_screan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const LogIn(),
      initialRoute:
          _auth.currentUser != null ? 'homechatscreen' : 'welcomePage',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white70,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        'welcomePage': (context) => const WelcomePage(),
        'signup': (context) => const SignUp(),
        'login': (context) => const LogIn(),
        'chatscreen': (context) => const ChatScreen(),
        'homechatscreen': (context) => const HomeChatScreen(),
      },
    );
  }
}
