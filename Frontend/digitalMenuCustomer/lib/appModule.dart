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
          '/home/:storeId',
          child: (_, args) => MenuHome(storeId: args.params['storeId']),
        ),
      ];
  @override
  Widget get bootstrap => MyApp();
}
