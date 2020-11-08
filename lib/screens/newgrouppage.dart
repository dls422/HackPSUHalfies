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
  var checked = new List();
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
              },
              maxLines: 4,
            ),
            IconButton(
                icon: Icon(Icons.add),
                iconSize: 100,
                onPressed: () {
                  data.insert(0, groupName);
                  Navigator.pop(context, data);
                }),
            Expanded(
              child:
              ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  print(data);
                  if(checked.length < names.length) {
                    print("wine pon");
                    checked = new List<bool>.filled(names.length + 1, false);
                  }
                  return Container(
                      height: 50,
                      child:
                      CheckboxListTile(
                        title: Text("${names[index]}"),
                        value: checked[index],
                        onChanged: (bool value)
                        {
                          print(data);
                          if(value)
                            {
                              data.add(names[index]);
                            }
                          else
                            {
                              data.remove(names[index]);
                            }
                          setState(() {
                            checked[index] = value;
                          });
                        },
                      )

                      // Row(
                      //   children: [
                      //
                      //       Text("${names[index]}"),
                      //       Checkbox(
                      //         value: checked[index],
                      //         onChanged: (newValue)
                      //         {
                      //           print(checked[index]);
                      //           if(newValue == true)
                      //           {
                      //             data.add(names[index]);
                      //           }
                      //           else
                      //           {
                      //             data.remove(names[index]);
                      //           }
                      //           setState(() {
                      //             checked[index] = newValue;
                      //           });
                      //         },
                      //       ),
                      //
                      //     ],
                      // ),


                  );
                },


              ),

            )

          ],

        ));
  }
}

