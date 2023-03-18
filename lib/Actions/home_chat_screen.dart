// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:text_me/Actions/home_line_screen.dart';

late User signedUser;

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  String? messageText;
  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      signedUser = user;
    }
    signedUser.photoURL;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  bool signOutLoading = false;
  @override
  Widget build(BuildContext context) {
    //final routeArgument =
    //  ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    //final categoryName = routeArgument['name'];
    //final categoryPicture = routeArgument['picture'];
    //final categoryEmail = routeArgument['email'];
    return ModalProgressHUD(
      inAsyncCall: signOutLoading,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black54,
            backgroundColor: Colors.orange[700],
            title: const Text(
              'TextMe',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Colors.white),
              )
            ],
            bottom: const TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text(
                  'Chats',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Tab(
                child: Text('Status',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              Tab(
                child: Text('Calls',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ]),
          ),
          drawer: Drawer(
            child: Column(children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('images/welcome.png'),
                ),
                accountName: Text('${signedUser.displayName}'),
                accountEmail: Text('${signedUser.email}'),
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
              ),
              const Divider(thickness: 1),
              TextButton(
                onPressed: () {},
                child: const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ),
              const Divider(thickness: 1),
              TextButton(
                onPressed: () {},
                child: const ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                ),
              ),
              const Divider(thickness: 1),
              TextButton(
                onPressed: () async {
                  setState(() {
                    signOutLoading = true;
                  });
                  await _auth.signOut();
                  Navigator.of(context).pushReplacementNamed('welcomePage');
                  setState(() {
                    signOutLoading = false;
                  });
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                ),
              ),
            ]),
          ),
          body: const TabBarView(children: [
            HomeLineScreen(),
            Center(child: Text("Status page does not implemented yet.")),
            Center(child: Text("Call page does not implemented yet."))
          ]),
        ),
      ),
    );
  }
}
