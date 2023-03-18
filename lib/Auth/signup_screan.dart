// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:text_me/Auth/button_ls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String confirmPassword;

  bool signLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: signLoading,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 190,
                child: Image.asset(
                  'images/welcome.png',
                ),
              ),
              const SizedBox(height: 10),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'email',
                        prefixIcon: Icon(Icons.email),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
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
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        hintText: 'confirm password',
                        prefixIcon: Icon(Icons.password),
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    Row(children: [
                      const SizedBox(width: 10),
                      const Text(
                        "Do have an account ?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('login');
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
              ),
              ButtonLS(
                title: 'Sign up',
                onPressed: () async {
                  setState(() {
                    signLoading = true;
                  });
                  try {
                    if (password == confirmPassword) {
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      Navigator.of(context).pushReplacementNamed('login');
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            title: Text("Try again"),
                            content: Text(
                              'Confirm Password is incorrect',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    setState(() {
                      signLoading = false;
                    });
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context)
                                        .pushReplacementNamed('signup');
                                    signLoading = false;
                                  });
                                },
                                child: const Text("Cancel")),
                          ],
                          title: const Text("Error"),
                          content: Text(
                            '$e',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
