import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: "Code"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please fill this";
                    } else {
                      return null;
                    }
                  },
                ),
                FlatButton(
                  child: Text("Get Menu"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Modular.to.pushReplacementNamed('/home',
                          arguments: _controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
