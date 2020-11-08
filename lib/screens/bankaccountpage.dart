import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_list.dart';


List bank_accounts = ["123456","654321","jeff", "827137", "111111"];
//List of example bank accounts


class BankAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Bank Account';
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            alignment: Alignment.topCenter,
            child: Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)),
          ),
          TextFormField(
            validator: (value) {

              if (value.isEmpty) {
                return 'Please enter a valid bank account ID';
              }
              if (!bank_accounts.contains(value)){
                return "Please enter a valid bank account ID";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.

                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Data Processed')));
                  final fb = FirebaseDatabase.instance;
                  final ref = fb.reference();
                  ref.child(FirebaseAuth.instance.currentUser.uid).child("Bank_Account").set(_formKey.currentState);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}