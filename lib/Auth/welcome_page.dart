// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool signLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: signLoading,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 80),
            Image.asset(
              'images/welcome_image.png',
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'In TEXTME APP ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'A simple chat platform for everyday use.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 180),
            SizedBox(
              width: 150,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 7),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 17,
                      color: Colors.black87,
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
