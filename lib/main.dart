import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:halfsies/screens/homepage.dart';
import 'package:halfsies/screens/loginpage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}
class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> _initilization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initilization,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        if(snapshot.connectionState == ConnectionState.done)
          {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.active){
                    User user = snapshot.data;
                    if(user == null) {
                      return LoginPage();
                    }
                    else {
                      return HomePage();
                    }
                  }
                return Scaffold(
                  body: Center(
                    child: Text("Checking Authentification..."),
                  ),
                );

              },
            );
          }
        return Scaffold(
          body: Center(
            child: Text("Connecting to the database..."),
          ),
        );
      },
    );
  }
}

class Group {
  Group(String name)
  {
    this.name = name;
  }

  String name;
  var members = new List<String>();
  Account owner;

  void addMember(String account)
  {
    this.members.add(account);
  }

  void removeMember(int index) {
    this.members.removeAt(index);
  }

}

class Account {
  String name;

  void setName(String name)
  {
    this.name = name;
  }
}

class BankAccount {
  BankAccount({String cardNumber, String CVV, String expDate}){
    this.cardNumber = cardNumber;
    this.CVV = CVV;
    this.expDate = expDate;
  }

  String cardNumber;
  String CVV;
  String expDate;
}