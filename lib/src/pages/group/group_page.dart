import 'dart:io';

import 'package:chat/src/pages/foundation/msg_widget/other_msg_widget.dart';
import 'package:chat/src/pages/foundation/msg_widget/own_msg_widget.dart';
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
    socket = IO.io('http://127.0.0.1:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) => print('connect into frontend'));
    socket!.on("sendMsgServer", (msg) {
     print(msg);
    setState(() {
      listMsg.add(
      MsgModel(
        msg: msg["msg"],
         type: msg["type"], 
         Sender: msg["sendName"]));      
    });
    }

    );

  }

  void sendMsg(String msg, String SenderName) {
    MsgModel OwnMsg =MsgModel(msg: msg, type: "OwnMsg", Sender: SenderName); 
    listMsg.add(OwnMsg);
    setState(() {
      listMsg;
    });
   socket!.emit('sendMsg',{
   "type": "OwnMsg",
   "msg": msg,
   "SenderName": SenderName
   });

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
            child: ListView.builder(
              itemCount: listMsg.length,
              itemBuilder: (context, index) {
                if(listMsg[index].type == "OwnMsg"){
                  return OwnMsgWidget(
                    sender: listMsg[index].Sender,
                     msg: listMsg[index].msg);
                } else{
                  return OtherMsgWidget(
                    sender: listMsg[index].Sender,
                     msg: listMsg[index].msg);
                }
                  
              }

            ),
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
                    String msg = _msgcontroller.text;
                    if(msg.isNotEmpty){
                    sendMsg(_msgcontroller.text, widget.name);
                    _msgcontroller.clear();

                    }

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
