import 'package:flutter/material.dart';
import 'package:halfsies/screens/homepage.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  String groupName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create a new group'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: new InputDecoration(hintText: "Group name"),
              onChanged: (value) {
                groupName = value;
              },
              maxLines: 4,
            ),
            IconButton(
                icon: Icon(Icons.add),
                iconSize: 100,
                onPressed: () {
                  Navigator.pop(context, groupName);
                })
          ],
        ));
  }
}
