import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatefulWidget {
  // ConfirmPage(this.pendomdata, {Key key});
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        "Yakin Di Hapus  ???",
        style: TextStyle(fontSize: 16.0, color: Colors.red),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.yellow,
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    // showAboutDialog(context: );
    // showDialog(context: context);
  }
}
