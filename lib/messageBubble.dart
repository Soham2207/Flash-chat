import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    @required this.sender,
    @required this.text,
    @required this.isMe,
  });
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.black54, fontSize: 10.0),
          ),
          Material(
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: isMe
                    ? TextStyle(fontSize: 15.0)
                    : TextStyle(color: Colors.black, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
