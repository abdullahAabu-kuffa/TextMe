import 'package:flutter/material.dart';

class HomeLineScreen extends StatelessWidget {
  const HomeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
            selectedTileColor: Colors.orange[700],
            leading: const CircleAvatar(
              backgroundImage: AssetImage('images/welcome.png'),
            ),
            title: const Text('TextMe'),
            trailing: const Icon(Icons.group),
            onTap: () => {Navigator.of(context).pushNamed('chatscreen')}),
      ),
    );
  }
}
