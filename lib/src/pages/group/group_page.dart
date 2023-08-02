import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class GroupPage extends StatefulWidget {
  final String name;
  const GroupPage({super.key, required this.name});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect(){
    // Dart client
  IO.Socket socket = IO.io('http://localhost:3000');
  socket.onConnect((_) {
    print('connect into frontend');
    socket.emit('sendMsg', 'test emit event');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
title: const Text("Anonymous grp"),
   ) ,
   body: Column(
    children: [
      Expanded(child: Container(),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Type here ...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide()
                  ),
                ),
                ),
                ),
                IconButton(onPressed: (){},
                 icon: const Icon(Icons.send,
                 color: Colors.teal,
                 ))
          ]),)
    ],
    
   ),
    );
  }
}