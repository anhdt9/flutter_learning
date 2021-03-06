import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("baby").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return _buildBody(context, snapshot.data.documents);
            }));
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return _buildList(context, snapshot);
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.votes.toString()),
            onTap: () => {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      child: CupertinoAlertDialog(
                        title: Text(
                          "Vote up",
                        ),
                        content: Text(
                          "Vote up ${record.name} ?",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => {
                              Isolate.spawn(voteUp(record), "do vote up!"),
//                              compute((_){
//                                voteUp(record);
//                              },{}),

//                              compute<Record, Future<void>>(voteUp, record),
                              Navigator.of(context).pop()
                            },
                            child: Text("Yes"),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("No"),
                          )
                        ],
                      ))
                }),
      ),
    );
  }

  /*Future<void>*/ voteUp(Record record) => record.reference.updateData({'votes': FieldValue.increment(1)});
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
