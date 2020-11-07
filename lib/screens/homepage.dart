import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'newgrouppage.dart';
import 'settingspage.dart';
import 'bankaccountpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
List<Group> _groups = <Group>[
];

class _HomePageState extends State<HomePage> {
  Widget _dialogBuilder(BuildContext context, Group group) {
    return SimpleDialog(
        children: [
      Container(
        width: 50,
        height: 400,
      ),
    ]);
  }

  Widget _listItemBuilder(BuildContext context, int index) {

    return new GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => _dialogBuilder(context, _groups[index]),
      ),
      child: Container(
          margin: EdgeInsets.all(15),
          color: Colors.lightBlueAccent[100],
          alignment: Alignment.center,
          child: Text(_groups[index].name,
              style: Theme.of(context).textTheme.headline)),

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings', 'Bank Account'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        title: Text("${FirebaseAuth.instance.currentUser.email}"),
      ),
      body: ListView.builder(
        itemCount: _groups.length,
        itemExtent: 150.0,
        itemBuilder: _listItemBuilder,

      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent[900],
          onPressed:  () async {
            final name = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewGroupPage()));
            if(name!=null) {
              _addGroup(name);
            }
          }),
    );
  }
  void _addGroup(_name)
  {
    final fb = FirebaseDatabase.instance;
    final ref = fb.reference();
    setState(() {
      _groups.add(Group(name: _name));
      ref.child(FirebaseAuth.instance.currentUser.uid).child("Groups").child(_name).set(["People", "In", "Group"]);
      //this will add to the database with the temporary data of "People", "In", and "Group", when we implement groups properly (with actual other users), change this
    });
  }


  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        FirebaseAuth.instance.signOut();
        break;
      case 'Settings':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SettingsPage()));
        break;
      case 'Bank Account' :
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BankAccountPage()));

        break;
    }
  }

}


