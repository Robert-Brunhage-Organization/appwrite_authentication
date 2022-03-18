import 'package:appwrite/appwrite.dart';
import 'package:appwrite_authentication/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/home_view.dart';
import '../login/login_view.dart';
import '../validation.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

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
                'Register',
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
                onPressed: validateAndRegister,
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, LoginView.routeName);
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> validateAndRegister() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Register logic here
      try {
        await ref.read(appwriteAccountProvider).create(
              userId: 'unique()',
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
