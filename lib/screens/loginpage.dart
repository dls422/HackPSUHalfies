import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halfsies/main.dart';
import 'package:halfsies/screens/homepage.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  String _dn;
  Future<void> _createUser() async
  {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch(e) {
      print("Error: $e");
    }
  }

  Future<void> _login() async
  {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch(e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                _email = value;
              },
              decoration: InputDecoration(
                hintText: "Email Address"
              ),
            ),
            TextField(
              obscureText: true,

              onChanged: (value) {
                _password = value;
              },

              decoration: InputDecoration(
                hintText: "Password"
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: _login,
                  child: Text("Login"),
                ),
                MaterialButton(
                  child: Text("Create New Account"),
                  onPressed: ()
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateUser()));
                  },
                )

              ],
            )
          ],
        ),
      )
    );
  }
}
class CreateUser extends StatelessWidget {
  String _dn, _password, _email;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Create Account"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    _dn = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Display Name"
                  ),
                ),

                TextField(
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Email Address"
                  ),
                ),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },

                  decoration: InputDecoration(

                      hintText: "Password"
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      child: Text("Create New Account"),
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance.createUserWithEmailAndPassword(
                              email: _email, password: _password);
                          final fb = FirebaseDatabase.instance;
                          final ref = fb.reference();
                          await FirebaseAuth.instance.currentUser.updateProfile(displayName: _dn);
                          await ref.child(FirebaseAuth.instance.currentUser.uid).child("Display Name").set(_dn);
                          await ref.child(FirebaseAuth.instance.currentUser.uid).child("Email").set(_email);
                          //adds the new account to the database so that we can eventually search through users
                        } on FirebaseAuthException catch (e) {
                          print("Error: $e");
                        } catch (e) {
                          print("Error: $e");
                        }
                        Navigator.pop(context);

                      }
                    ),

                  ],
                )
              ],
            ),
          )
      );
  }
}
