import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Profile bar
            Card(
              color: Colors.lightBlueAccent[100],
              child: ListTile(
                  leading: Icon(Icons.sentiment_satisfied,
                      size: 40, color: Colors.black),
                  title: Text('${FirebaseAuth.instance.currentUser.email}',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  subtitle: Text("\$0",
                      style: TextStyle(
                        fontSize: 16,
                      ))),
            ),
            //Change password button
            const SizedBox(height: 25),
            Text('   Account settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: (FontWeight.bold),
                )),
            Card(
                margin:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                elevation: 5,
                shape: RoundedRectangleBorder(),
                child: Column(children: <Widget>[
                  ListTile(
                    title: Text('Change password'),
                    onTap: () async
                    {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: FirebaseAuth.instance.currentUser.email);
                    },
                    leading:
                    Icon(Icons.lock, color: Colors.lightBlueAccent[200]),
                    trailing: Icon(Icons.arrow_forward_ios),
                  )
                ])),
            const SizedBox(height: 25),
            Text('   Banking settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: (FontWeight.bold),
                )),
            SwitchListTile(
              activeColor: Colors.lightBlueAccent[400],
              inactiveThumbColor: Colors.grey,
              value: _notifs,
              title: Text(
                'Push notifications',
                style: TextStyle(color: Colors.black),
              ),
              onChanged: (bool value) {
                setState(() {
                  _notifs = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}