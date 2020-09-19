import 'package:digitalMenu/UI/Auth/loginScreen.dart';
import 'package:digitalMenu/UI/Auth/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Colors.blue[200],
          ),
          Container(
            padding: EdgeInsets.all(18),
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.white,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GFButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      text: "Login",
                      type: GFButtonType.outline2x,
                      shape: GFButtonShape.standard,
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: GFButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      text: "Register",
                      type: GFButtonType.outline2x,
                      shape: GFButtonShape.standard,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
