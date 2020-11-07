import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

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
                  onPressed: _createUser,

                  child: Text("Create New Account"),
                )

              ],
            )
          ],
        ),
      )
    );
  }
}
