import 'dart:developer';
import 'package:chat/constant/my_colors.dart';
import 'package:chat/model/Message_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final Users user;

  ChatScreen(this.user);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var text_controller = TextEditingController();
  final firebaseInstance = FirebaseFirestore.instance.collection('messages');
  var key_relation;

  void Sendmsg(var text) async {
    return firebaseInstance.add({
      "message": text,
      "time": int.parse(_getCurrentTime()),
      "sender": _auth.currentUser?.uid,
      "receiver": widget.user.userid,
      "relation": key_relation
    }).then((value) {
      log("Message send");
    }).catchError((error) {
      log("Message failed");
    });
  }

  void docxist() {
    firebaseInstance
        .where('relation', isEqualTo: key_relation)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        print("first try failed");
        key_relation = widget.user.userid + _auth.currentUser!.uid;

        firebaseInstance
            .where('relation', isEqualTo: key_relation)
            .get()
            .then((value2) {
          if (value2.docs.isEmpty) {
            /*
                first time chat
                 */
          } else {
            setState(() {
              key_relation = widget.user.userid + _auth.currentUser!.uid;
            });
            print("key is ok");
          }
        });
      }
    });
  }

  @override
  void initState() {
    key_relation = (_auth.currentUser!.uid + widget.user.userid);
    docxist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors().allColor,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/avatar.jpg")),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  widget.user.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700),
                ),
              ],
            )),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: _chatlist(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Center(child: CircularProgressIndicator());
                }
                List<Message> children = snapshot.data!.docs
                    .map((e) => Message(e['message'].toString(),
                        e['sender'].toString(), e['receiver'].toString()))
                    .toList();
                return Container(
                  child: ListView.builder(
                    itemCount: children.length,
                    itemBuilder: (context, index) {
                      if (children[index].sender == _auth.currentUser?.uid) {
                        return sender(children[index].message);
                      } else {
                        return receiver(children[index].message);
                      }
                    },
                  ),
                );
              },
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: send(),
            )
          ],
        ));
  }

  Widget sender(var text) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          margin: const EdgeInsets.only(right: 10, top: 9.0),
          decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(7.0)),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          )),
    );
  }

  Widget receiver(var text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          margin: const EdgeInsets.only(left: 10, top: 9.0),
          decoration: BoxDecoration(
              color: const Color(0xfff1f0f5),
              borderRadius: BorderRadius.circular(7.0)),
          child: Text(
            text,
            style:
                const TextStyle(color: const Color(0xff1c3865), fontSize: 18.0),
          )),
    );
  }

  Widget send() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                color: MyColors().allColor,
                borderRadius: BorderRadius.circular(28.0)),
            child: InkWell(
              onTap: () {
                Sendmsg(text_controller.text);
                text_controller.text = "";
              },
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xfff2f1f6),
                    borderRadius: BorderRadius.circular(28.0)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: text_controller,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'پیام',
                      hintStyle:
                          TextStyle(fontSize: 18.0, color: Color(0xffa8a5b9)),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentTime() {
    var now = DateTime.now();
    var date =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}"
        "${now.hour.toString().padLeft(2, '0')}"
        "${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
    return date;
  }

  Stream<QuerySnapshot> _chatlist() {
    return firebaseInstance
        .where('relation', isEqualTo: key_relation)
        .orderBy('time')
        .snapshots();
  }
}
