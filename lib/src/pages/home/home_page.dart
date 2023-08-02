import 'package:chat/src/pages/group/group_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Chat App"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => showDialog(
            context: context,
             builder: (BuildContext context) => AlertDialog(
              title: const Text("Please enter your name"),
              content: Form(
                key: formkey,
                child: TextFormField(
                  controller: nameController,
                  validator: (value){
                    if(value == null || value.length<3){
                      return "User must have proper name";
                    }
                    return null;
                  }
              
                ),
              ),
              actions: [
                                                  TextButton(onPressed: (){
                                                                        nameController.clear();

                                                    //return initial page
                                                    Navigator.pop(context);
                                                  },
                 child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16, 
                  color: Colors.red),
                  )
                  ),
                TextButton(onPressed: (){
                  // print(nameController.text);
                  if(formkey.currentState!.validate()){
                    String name = nameController.text;
                    nameController.clear();
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(
                    builder: (context) =>  GroupPage(name:name)));
                  }

                },
                 child: const Text(
                  "Enter",
                  style: TextStyle(fontSize: 16, 
                  color: Colors.orange),
                  )
                  ),

              ],
             )
             
             ), 
             child: const Text(
              "Initite Group chat",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 16,
              ),
              ),
             ), 
          
         ),
      );
      
  }
}