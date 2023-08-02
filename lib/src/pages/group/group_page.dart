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
   body: Text(widget.name),
    );
  }
}