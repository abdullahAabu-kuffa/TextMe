import 'package:flutter/material.dart';

class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender, this.isMe, super.key});
  final String? text;
  final String? sender;
  final bool? isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: const TextStyle(
                fontSize: 12,
                color: Colors.black45,
                fontWeight: FontWeight.bold),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe!
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
            color: isMe! ? Colors.orange[500] : Colors.blueGrey[700],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
