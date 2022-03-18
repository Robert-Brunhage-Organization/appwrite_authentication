import 'package:flutter/material.dart';

import 'authentication/login/login_view.dart';
import 'authentication/register/register_view.dart';
import 'home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      onGenerateTitle: (context) => 'Appwrite Authentication',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute<void>(
          builder: (context) {
            switch (routeSettings.name) {
              case LoginView.routeName:
                return const LoginView();
              case RegisterView.routeName:
                return const RegisterView();
              case HomeView.routeName:
                final args = routeSettings.arguments! as HomeViewArguments;
                return HomeView(email: args.email);
              default:
                return const LoginView();
            }
          },
        );
      },
    );
  }
}
