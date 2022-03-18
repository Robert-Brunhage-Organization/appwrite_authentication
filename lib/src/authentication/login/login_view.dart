import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../home/home_view.dart';
import '../register/register_view.dart';
import '../validation.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  Future<void> checkCurrentUser() async {
    try {
      final user = await ref.read(appwriteAccountProvider).get();
      Navigator.of(context).pushReplacementNamed(
        HomeView.routeName,
        arguments: HomeViewArguments(email: user.email),
      );
    } on AppwriteException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: emailValidation,
                onSaved: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                validator: passwordValidation,
                onSaved: (value) => password = value,
              ),
              ElevatedButton(
                onPressed: validateAndLogin,
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RegisterView.routeName,
                  );
                },
                child: const Text('Register'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateAndLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Login logic here
        await ref.read(appwriteAccountProvider).createSession(
              email: email!,
              password: password!,
            );
        Navigator.of(context).pushReplacementNamed(
          HomeView.routeName,
          arguments: HomeViewArguments(email: email!),
        );
      } on AppwriteException catch (e) {
        debugPrint(e.message);
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('password', password));
    properties.add(StringProperty('email', email));
  }
}
