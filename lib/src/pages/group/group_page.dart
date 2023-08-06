import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../foundation/msg_widget/other_msg_widget.dart';
import '../../foundation/msg_widget/own_msg_widget.dart';
import 'msg_model.dart';

class GroupPage extends StatefulWidget {
  final String name;
  final String userId;
  static int instancesCount = 0;

   GroupPage({Key? key, required this.name, required this.userId})
      : super(key: key) {
      instancesCount++;

      }
  


  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  IO.Socket? socket;
  List<MsgModel> listMsg = [];


  TextEditingController _msgcontroller = TextEditingController();

  @override
  void dispose() {
    // Decrement the instancesCount when the instance is disposed
    GroupPage.instancesCount--;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    // Dart client
    socket = IO.io('http://127.0.0.1:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {
    print('connect into frontend - Total instances: ${GroupPage.instancesCount}');
      socket!.on("sendMsgServer", (msg) {
        print(msg);
        if (msg["userId"] != widget.userId &&
            msg["msg"] != null &&
            msg["type"] != null &&
            msg["senderName"] != null) {
          setState(() {
            listMsg.add(
              MsgModel(
                msg: msg["msg"],
                type: msg["type"],
                Sender: msg["senderName"],
              ),
            );
      
           });
        }
      });
    });
  }

  void sendMsg(String msg, String SenderName) {
    MsgModel ownMsg = MsgModel(msg: msg, type: "OwnMsg", Sender: SenderName);
    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });
    socket!.emit("sendMsg", {
      "type": "OwnMsg",
      "msg": msg,
      "SenderName": SenderName,
      "userId": widget.userId,
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("anomynous group"),
      ),
      body: Column(
        children: [
          Expanded(
           child: ListView.builder(
              itemCount: listMsg.length,
              itemBuilder: (context, index) {
                if (listMsg[index].type == "OwnMsg") {
                  // Render OwnMsgWidget for own messages
                  return OwnMsgWidget(
                    msg: listMsg[index].msg,
                    sender: listMsg[index].Sender,
                  );
                } else {
                  // Render OtherMsgWidget for other messages
                  return OtherMsgWidget(
                    msg: listMsg[index].msg,
                    sender: listMsg[index].Sender,
                  );
                }
  },
),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _msgcontroller,
                    decoration: InputDecoration(
                      hintText: "Type here ...",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          String msg = _msgcontroller.text;
                          if (msg.isNotEmpty) {
                            sendMsg(msg, widget.name);
                            _msgcontroller.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.teal,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

