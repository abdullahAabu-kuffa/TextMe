import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_me/Actions/chat_screen.dart';

class HomeLineScreen extends StatefulWidget {
  const HomeLineScreen({super.key});

  @override
  State<HomeLineScreen> createState() => _HomeLineScreenState();
}

class _HomeLineScreenState extends State<HomeLineScreen> {
  bool selColor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/icon3.png'),
                ),
                title: const Text('TextMe Group'),
                subtitle: const Text(
                  '00:01                                            today',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                trailing: const Icon(Icons.access_time_rounded),
                onTap: () {
                  setState(() {
                    selColor = true;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                  setState(() {
                    selColor = false;
                  });
                }),
            ListTile(
                selectedTileColor: Colors.orange[700],
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/me.png'),
                ),
                title: const Text('A.Abu-kuffa'),
                subtitle: const Text(
                  '08:25                                     yesterday',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                trailing: const Icon(Icons.access_time_filled_sharp),
                onTap: () {}),
            ListTile(
                selectedTileColor: Colors.orange[700],
                selected: selColor,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/Khedira.jpg'),
                ),
                title: const Text('Khedira'),
                subtitle: const Text(
                  '22:39                                     yesterday',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                trailing: const Icon(Icons.access_time_rounded),
                onTap: () {}),
            ListTile(
                selectedTileColor: Colors.orange[700],
                selected: selColor,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/Badr.jpg'),
                ),
                title: const Text('Ahmed Badr'),
                subtitle: const Text(
                  '15:12                                   22/2/2023',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                trailing: const Icon(Icons.access_time_filled_sharp),
                onTap: () {}),
            ListTile(
                selectedTileColor: Colors.orange[700],
                selected: selColor,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/Shokaa.jpg'),
                ),
                title: const Text('Shokaa'),
                subtitle: const Text(
                  '15:57                                     7/3/2023',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                trailing: const Icon(Icons.access_time_filled_sharp),
                onTap: () {}),
            ListTile(
                selectedTileColor: Colors.orange[700],
                selected: selColor,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/Shahd.jpg'),
                ),
                title: const Text('Shahd'),
                subtitle: const Text(
                  '12:55                                   10/3/2023',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                trailing: const Icon(Icons.access_time_filled_sharp),
                onTap: () {}),
            ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/Tathnim.jpg'),
                ),
                title: const Text('Tathniim'),
                subtitle: const Text(
                  '15:12                                   22/2/2023',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                trailing: const Icon(Icons.access_time_filled_sharp),
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
