import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../home/home_view.dart';
import '../register/register_view.dart';
import '../validation.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  void validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Login logic here
      Navigator.of(context).pushReplacementNamed(
        HomeView.routeName,
        arguments: HomeViewArguments(email: email!),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('password', password));
    properties.add(StringProperty('email', email));
  }
}
