// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'messageline_screen.dart';
import 'package:text_me/Actions/home_chat_screen.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String? messageText;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.orange[700],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('images/welcome.png'),
            ),
            SizedBox(width: 10),
            Text(
              'TextMe',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/wallpaper2.jpg'), fit: BoxFit.cover),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 18),
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type...',
                        hintStyle: TextStyle(
                          color: Colors.black54,
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
                    child: Icon(Icons.send, color: Colors.orange[700]),
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
