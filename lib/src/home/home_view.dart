import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeViewArguments {
  const HomeViewArguments({required this.email});
  final String email;
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.email}) : super(key: key);
  static const String routeName = '/home';
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('email', email));
  }
}
