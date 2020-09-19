import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'UI/home.dart';
import 'UI/menuHome.dart';
import 'myApp.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => Home()),
        ModularRouter(
          '/home',
          child: (_, args) => MenuHome(storeId: args.data),
        ),
      ];

  @override
  Widget get bootstrap => MyApp();
}
