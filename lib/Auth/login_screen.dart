// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:text_me/Auth/button_ls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  late String email;
  late String password;

  bool signLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: signLoading,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'images/welcome.png',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      child: Column(children: [
                        TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'email',
                            prefixIcon:
                                Icon(Icons.supervised_user_circle_sharp),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            password = value;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            hintText: 'password',
                            prefixIcon: Icon(Icons.password),
                            contentPadding:
                                EdgeInsets.only(top: 10, right: 20, left: 20),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                        ),
                        Row(children: [
                          const SizedBox(width: 15),
                          const Text(
                            "Don't have an account ?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('signup');
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ]),
                      ]),
                    ),
                    ButtonLS(
                      title: 'Log in',
                      onPressed: () async {
                        setState(() {
                          signLoading = true;
                        });
                        try {
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);

                          Navigator.of(context)
                              .pushReplacementNamed('chatscreen');

                          setState(() {
                            signLoading = false;
                          });
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context)
                                              .pushReplacementNamed('login');
                                          signLoading = false;
                                        });
                                      },
                                      child: const Text("Cancel")),
                                ],
                                title: const Text("Error"),
                                content: Text(
                                  '$e',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Or connect using',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              signLoading = true;
                            });
                            try {
                              GoogleSignInAccount? googleSignInAccount =
                                  await _googleSignIn.signIn();
                              Navigator.of(context)
                                  .pushReplacementNamed('chatscreen');
                              setState(() {
                                signLoading = false;
                              });
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      'login');
                                              signLoading = false;
                                            });
                                          },
                                          child: const Text("Cancel")),
                                    ],
                                    title: const Text("Error"),
                                    content: Text(
                                      '$e',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: const Text(
                            'Google',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}
