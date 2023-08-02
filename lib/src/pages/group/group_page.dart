import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  final String name;
  const GroupPage({super.key, required this.name});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
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