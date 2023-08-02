import 'dart:io';

import 'package:chat/src/pages/group/msg_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GroupPage extends StatefulWidget {
  final String name;
  const GroupPage({super.key, required this.name});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  IO.Socket? socket;
  List<MsgModel> listMsg = [];
  TextEditingController _msgcontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect() {
    // Dart client
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) => print('connect into frontend'));
  }

  void sendMsg(String msg, String SenderName) {
   socket!.emit('sendMsg', {
   "type": "OwnMsg",
   "msg": msg,
   "SenderName": SenderName});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anonymous grp"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(children: [
              Expanded(
                child: TextFormField(
                  controller: _msgcontroller,
                  decoration: const InputDecoration(
                    hintText: "Type here ...",
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    sendMsg(_msgcontroller.text, widget.name);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.teal,
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
