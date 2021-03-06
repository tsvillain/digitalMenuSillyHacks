import 'package:digitalMenu/Bloc/storeBloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:getwidget/getwidget.dart';

import '../homePage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  StoreBloc _storeBloc;
  @override
  Widget build(BuildContext context) {
    _storeBloc = BlocProvider.of<StoreBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email Id",
                      hintText: "silly@hacks.online"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter a Email Id";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Sj78!******"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter a Password";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GFButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      bool value = await _storeBloc.loginUser(
                        _emailController.text,
                        _passController.text,
                      );
                      if (value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } else {
                        print("Please Try Again Later");
                      }
                    }
                  },
                  text: "Login",
                  type: GFButtonType.outline2x,
                  shape: GFButtonShape.standard,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
