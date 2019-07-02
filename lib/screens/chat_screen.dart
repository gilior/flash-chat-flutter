import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser currentUser;

class ChatScreen extends StatefulWidget {
  static const id = 'ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String msg_txt;

  TextEditingController txt_edit_ctrl = TextEditingController();

  get_all_messages() async {
    final msgs = await _firestore.collection(msgs_tbl).getDocuments();
    for (var doc in msgs.documents) {}
  }

  void msgs_stream() async {
    await for (var snap_shot in _firestore.collection(msgs_tbl).snapshots()) {
      for (var doc in snap_shot.documents) {}
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load_user();
  }

  Future load_user() async {
    currentUser = await _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Msg_Stream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: txt_edit_ctrl,
                      onChanged: (value) {
                        //Do something with the user input.
                        msg_txt = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages').document().setData(
                          {'text': msg_txt, 'sender': currentUser.email});

                      txt_edit_ctrl.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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

class Msg_Stream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(msgs_tbl).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final msgs = snapshot.data.documents.reversed;
        List<Msg_Bubble> msgs_wdg = [];
        for (var msg in msgs) {
          final msg_txt = msg.data['text'];
          final snd = msg.data['sender'];

          final txt_wdg = Msg_Bubble(snd, msg_txt, snd == currentUser.email);
          msgs_wdg.add(txt_wdg);
        }
//                return Column(
//                  children: msgs_wdg,
//                );
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            children: msgs_wdg,
          ),
        );
      },
    );
  }
}

class Msg_Bubble extends StatelessWidget {
  final snd;

  final txt;

  final isMe;

  Msg_Bubble(this.snd, this.txt, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '$snd',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: !isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
//            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                '$txt',
                style: TextStyle(
                    fontSize: 15.0,
                    color: isMe ? Colors.white : Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
