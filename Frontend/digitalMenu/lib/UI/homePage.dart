import 'package:digitalMenu/Bloc/storeBloc.dart';
import 'package:digitalMenu/UI/Screens/accountScreen.dart';
import 'package:digitalMenu/UI/Screens/categoryScreen.dart';
import 'package:digitalMenu/UI/Screens/menuScreen.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  StoreBloc _storeBloc;

  getScreen(int index) {
    if (index == 0) {
      return MenuScreen(storeBloc: _storeBloc);
    } else if (index == 1) {
      return CategoryScreen(storeBloc: _storeBloc);
    } else if (index == 2) {
      return AccountScreen(storeBloc: _storeBloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    _storeBloc = BlocProvider.of<StoreBloc>(context);
    return Scaffold(
      body: Center(
        child: getScreen(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.blue[600],
                tabs: [
                  GButton(
                    icon: LineIcons.list,
                    text: 'Menu',
                  ),
                  GButton(
                    icon: LineIcons.server,
                    text: 'Categories',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
