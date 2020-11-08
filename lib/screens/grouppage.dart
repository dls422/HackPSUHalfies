import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  String groupName;
  var members;

  Widget _listItemBuilder(BuildContext context, int index) {
    return new Scaffold(
      body: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        shape: RoundedRectangleBorder(),
        child: Container(
          child: ListTile(
            title: Text(
              '',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
          title: Text('this.groupName'), //CHANGE
          backgroundColor: Colors.blueAccent[600],
          bottom: TabBar(
            tabs: [
              Tab(
                  text: 'MEMBERS (' +
                      '0' +
                      ')'), //CHANGE: number of members in the group
              Tab(text: 'PAYMENTS'),
            ],
          ),
        ),
        body: TabBarView(children: [
          //MEMBERS tab
          ListView.builder(
            itemCount: 0, //CHANGE: number of members
            itemExtent: 50.0,
            itemBuilder: _listItemBuilder,
          ),
          //PAYMENTS tab
          Text('gib money here'),
        ]),
      ),
    );
  }
}

void handleClick(String value) {
  switch (value) {
    case 'Edit members':
      break;
    case 'Add payments':
      break;
    case 'Delete group':
      break;
  }
}