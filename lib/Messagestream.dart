import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'messageBubble.dart';

class MessageStream extends StatelessWidget {
  final _cloudfirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedinUser;
  void getCurrentuser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    getCurrentuser();
    return StreamBuilder(
        stream: _cloudfirestore.collection('messages').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data.docs.reversed;
            List<MessageBubble> messageWidgets = [];
            for (QueryDocumentSnapshot<Map<String, dynamic>> message
                in messages) {
              final messageText = message.data()['text'];
              final messageSender = message.data()['sender'];

              final messageWidget = MessageBubble(
                sender: messageSender,
                text: messageText,
                isMe: messageSender == loggedinUser.email.toString(),
              );
              messageWidgets.add(messageWidget);
            }
            return Expanded(
              child: ListView(
                reverse: true,
                children: messageWidgets,
              ),
            );
          }
          return SizedBox();
        });
  }
}
