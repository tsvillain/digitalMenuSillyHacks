import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'Bloc/storeBloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: StoreBloc(),
      child: MaterialApp(
        initialRoute: "/",
        navigatorKey: Modular.navigatorKey,
        onGenerateRoute: Modular.generateRoute,
        title: 'DigiMenu',
      ),
    );
  }
}
