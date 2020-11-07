import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:halfsies/screens/homepage.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  String groupName;
  var data = new List();

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
                if(data.length == 0)
                  {
                    data.add(value);
                  }
                else {
                  data[0] = value;
                }
              },
              maxLines: 4,
            ),
            IconButton(
                icon: Icon(Icons.add),
                iconSize: 100,
                onPressed: () {
                  if(data.length >= 1) {
                    data.add("hen xd");
                    data.add("steven xd");
                    data.add("dan xd");
                    data.add("matt xd");
                    Navigator.pop(context, data);
                  }
                }),
          ],

        ));
  }
}
