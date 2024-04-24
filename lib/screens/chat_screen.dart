
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
User? loggedIn;
class ChatScreen extends StatefulWidget {
  static const String id = 'chatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  String? messages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedIn = user;

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Stream(),

            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        messages = value;
                        //Do something with the user input.
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        hintText: 'Type your message here...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageController.clear();
                      _fireStore
                          .collection('1')
                          .add({'text': messages, 'sender': loggedIn!.email});
                      //Implement send functionality.
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextBubble extends StatelessWidget {
  const TextBubble({super.key, this.sender, this.text, this.isMe});
  final String? sender;
  final String? text;
  final bool? isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe!? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender!,
            style: const TextStyle(fontSize: 12.0, color: Colors.black),
          ),
          Material(
            borderRadius: isMe!?const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30),):const BorderRadius.all(Radius.circular(30)),
            elevation: 7.0,
            color: isMe! ? Colors.lightBlueAccent:Colors.white ,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                '$text ',
                style:  TextStyle(fontSize: 15, color: isMe! ? Colors.white :Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class Stream extends StatelessWidget {
  const Stream({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('1').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(); // Placeholder for when data is loading
        }
        final messages = snapshot.data!.docs.reversed;
        List<TextBubble> messageBubbles = [];
        for (var message in messages) {
          final messageData = message.data()! as Map<String, dynamic>;
          final messageText = messageData['text'];
          final messageSender = messageData['sender'];
          final currentUser = loggedIn!.email;
          final messageBubble = TextBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded( // Use Expanded instead of Flexible here
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
