import 'package:flutter/material.dart';
import '../main.dart';

class BankAccountPage extends StatefulWidget {
  @override
  _BankAccountPageState createState() => _BankAccountPageState();
}

List<BankAccount> _bankAccounts = <BankAccount> [
  BankAccount(cardNumber: '9999 9999 9999', CVV: '999', expDate: '99/99'),
];

class _BankAccountPageState extends State<BankAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Account'),
      ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                alignment: Alignment.topCenter,
                child: Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)),
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: _bankAccounts.length,
                    itemExtent: 150.0,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        color: Colors.grey,
                        alignment: Alignment.center,
                        child: Text(
                          _bankAccounts[index].cardNumber,
                          style: Theme.of(context).textTheme.headline
                        )
                      );
                    }
                  ),
              ),
            ]
        ),
    );
  }
}
