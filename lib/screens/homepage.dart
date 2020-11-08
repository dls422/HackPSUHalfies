import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'newgrouppage.dart';
import 'settingspage.dart';
import 'bankaccountpage.dart';
import 'grouppage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<Group> _groups = <Group>[];

class _HomePageState extends State<HomePage> {
  Widget _listItemBuilder(BuildContext context, int index) {
    return new InkWell(
      onTap: () async {
        bool didDelete = await Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(group: _groups[index]),),);
        if(didDelete)
          {
            removeGroup(index);
          }
      },
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.account_circle, size: 42),
            title: Text(
              _groups[index].name,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            subtitle: Text(
              (_groups[index].members.length).toString() + ' members',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const Divider(
            thickness: 5,
          ),
        ],
      ),
    );
  }

  List getGroups() {
    List<Group> groups = new List();
    var db = FirebaseDatabase.instance
        .reference()
        .child("${FirebaseAuth.instance.currentUser.uid}")
        .child("Groups");
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        if (key != null) {
          String gName = key;
          List members = values;

          setState(() {
            Group ng = new Group(gName);
            for (int i = 0; i < members.length; i++) {
              ng.addMember(members[i].toString());
            }
            groups.add(ng);
          });
        }
      });
    });
    return groups;
  }

  @override
  void initState() {
    _groups = getGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings', 'Bank Account'}
                  .map((String choice) {
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
      body: _groups.length != 0
          ? ListView.builder(
              itemCount: _groups.length,
              itemExtent: 108.0,
              itemBuilder: _listItemBuilder,
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "You currently aren't in any groups.",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Click the button to create one!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent[900],
          onPressed: () async {
            final data = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewGroupPage()));
            if (data[0] != null) {
              _addGroup(data);
            }
          }),
    );
  }

  void _addGroup(data) {
    final fb = FirebaseDatabase.instance;
    final ref = fb.reference();
    setState(() {
      String _name = data[0];
      data.removeAt(0);
      Group grp = new Group(_name);
      for (int i = 0; i < data.length; i++)
      {
        grp.addMember(data[i]);
        print(data[i]);
      }
      _groups.add(grp);
      print(grp.members);

      ref
          .child(FirebaseAuth.instance.currentUser.uid)
          .child("Groups")
          .child(_name)
          .set(data);
    });
  }

  void removeGroup(int index)
  {
    setState(() {
      _groups.removeAt(index);
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        FirebaseAuth.instance.signOut();
        break;
      case 'Settings':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsPage()));
        break;
      case 'Bank Account':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BankAccountPage()));
        break;
    }
  }
}
