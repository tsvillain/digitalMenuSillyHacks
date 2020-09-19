import 'package:digitalMenu/Bloc/storeBloc.dart';
import 'package:digitalMenu/UI/homePage.dart';
import 'package:digitalMenu/UI/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: StoreBloc(),
      child: MaterialApp(
        title: 'DigiMenu',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CheckLogin(),
      ),
    );
  }
}

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  bool isLoading = true;
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String token = _preferences.getString("token");
    setState(() {
      isLoading = false;
    });
    if (token == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
