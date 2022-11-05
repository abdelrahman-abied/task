import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/shared_widget/default_form_field.dart';
import '../../../users/presentation/pages/user_page.dart';
import '../provider/login_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const String route = "login";
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultFormField(
                controller: _emailController,
                hint: "E-mail",
                validatorFunction: (value) {
                  if (value!.isEmpty) {
                    return 'Enter valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DefaultFormField(
                controller: _passwordController,
                hint: "Password",
                validatorFunction: (value) {
                  if (value!.isEmpty) {
                    return 'Enter password';
                  } else if (value.length < 6) {
                    return 'Password should be no less than 6 chars';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  final Usertatus = ref.watch(userLoginProvider).usertatus;
                  if (Usertatus == LoginStatus.unauthenticated) {
                    return const Text(
                      "Please enter Valid Email & Password",
                    );
                  } else {
                    return const Text("");
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () => _login(context),
                  child: const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
    } else {
      final loginStatus = await ref.read(userLoginProvider).login(
          email: _emailController.text, password: _passwordController.text);
      if (loginStatus == LoginStatus.authenticated) {
        GoRouter.of(context).goNamed(UserPage.route);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
