import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'newgrouppage.dart';
import 'settingspage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _dialogBuilder(BuildContext context, Group group) {
    return SimpleDialog(children: [
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
              return {'Logout', 'Settings'}.map((String choice) {
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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewGroupPage()));
          }),
    );
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
    }
  }
}

List<Group> _groups = <Group>[
  Group(name: 'Test Group 1'),
  Group(name: 'Test Group 2'),
  Group(name: 'Test Group 3'),
];
