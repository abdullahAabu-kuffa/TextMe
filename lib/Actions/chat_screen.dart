// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'messageline_screen.dart';

final _firestore = FirebaseFirestore.instance;
late User signedUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  String? messageText;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(214, 121, 68, 255),
        title: const Text(
          'Group of Text',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.local_phone)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam))
        ],
      ),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('images/welcome.png'),
            ),
            accountName: const Text("Text Me"),
            accountEmail: Text('${signedUser.email}'),
            decoration: BoxDecoration(
              color: Colors.orange[600],
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
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('welcomePage');
            },
            child: const ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
            ),
          ),
        ]),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg_image1.jpg'), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStreamBuilder(),
            Container(
              height: 50,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF455A64),
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('Messages').add({
                        'Text': messageText,
                        'Sender': signedUser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Row(
                      children: const [
                        VerticalDivider(
                          width: 10,
                          thickness: 1.5,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Send',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('Text');
          final messageSender = message.get('Sender');
          final cerruntUser = signedUser.email;
          final messageWidget = MessageLine(
            text: messageText,
            sender: messageSender,
            isMe: cerruntUser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListView(
              reverse: true,
              children: messageWidgets,
            ),
          ),
        );
      },
    );
  }
}
