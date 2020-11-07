import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:halfsies/screens/homepage.dart';
class NewGroupPage extends StatefulWidget {

  @override
  _NewGroupPageState createState() => _NewGroupPageState();

}

class _NewGroupPageState extends State<NewGroupPage> {
  String groupName;
  var data = new List();
  var names;
  List getNames()
  {
    var names = new List();
    var db = FirebaseDatabase.instance.reference();
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        print(values["Display Name"]);
        if(values["Display Name"]!= null) {
          setState(() {
            names.add(values["Display Name"]);
          });
        }
      });
    });
    return names;
  }

  @override
  void initState()
  {
    names = getNames();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create a new group'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: new InputDecoration(hintText: "Group name"),
              onChanged: (value) async {
                groupName = value;
                if(data.length == 0)
                  {
                    data.add(value);
                  }
                else {
                  data[0] = value;
                }
              },
              maxLines: 4,
            ),
            IconButton(
                icon: Icon(Icons.add),
                iconSize: 100,
                onPressed: () {
                  if(data.length >= 1) {
                    data.add("hen xd");
                    data.add("steven xd");
                    data.add("dan xd");
                    data.add("matt xd");
                    Navigator.pop(context, data);
                  }
                }),
            Expanded(
              child:
              ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 50,
                      child: Center(child: Text("${names[index]}"))
                  );
                },


              ),

            )

          ],

        ));
  }
}

