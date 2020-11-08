import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

import '../main.dart';

class GroupPage extends StatelessWidget {
  final Group group;
  BuildContext context1;
  bool editMembers = false;

  GroupPage({Key key, @required this.group}) : super(key: key);

  Widget _listItemBuilder(BuildContext context, int index) {
    return new Scaffold(
      body: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        shape: RoundedRectangleBorder(),
        child: Container(
          child: ListTile(
            title: Text(group.members[index],
              style: TextStyle(fontSize: 20),
            ),
            trailing: editMembers
            ? IconButton(
              icon: Icon(
                  Icons.remove_circle_rounded,
                color: Colors.red,),
              onPressed: () {
                group.removeMember(index);
                FirebaseDatabase.instance.reference().child(FirebaseAuth.instance.currentUser.uid).child("Groups").child(group.name).set(group.getMembers());
                //FirebaseDatabase.instance.reference().child(FirebaseAuth.instance.currentUser.uid).child("Groups").child(group.name).child(group.getMember(index)).remove();

                (context1 as Element).markNeedsBuild();
              },
            )
            : null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context1 = context;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Edit members', 'Add payments', 'Delete group'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          title: Text(group.name),
          backgroundColor: Colors.blueAccent[600],
          bottom: TabBar(
            tabs: [
              Tab(
                  text: 'MEMBERS (' +
                      '${group.members.length}' +
                      ')'),
              Tab(text: 'PAYMENTS'),
            ],
          ),
        ),
        body: TabBarView(children: [
          //MEMBERS tab
          ListView.builder(
            itemCount: group.members.length,
            itemExtent: 50.0,
            itemBuilder: _listItemBuilder,
          ),
          //PAYMENTS tab
          Text('gib money here'),
        ]),
      ),
    );
  }
  void handleClick(String value)
  {
    switch (value) {
      case 'Edit members':
        (context1 as Element).markNeedsBuild();
        if(editMembers)
          editMembers = false;
        else
          editMembers = true;
        break;
      case 'Add payments':
        break;
      case 'Delete group':
        FirebaseDatabase.instance.reference().child(FirebaseAuth.instance.currentUser.uid).child("Groups").child(group.name).remove();
        Navigator.pop(context1, true);
        break;
    }
  }

}

