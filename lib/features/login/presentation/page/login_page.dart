import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailEC = TextEditingController();
  final _passEC = TextEditingController();
  late final _controller = context.read<LoginCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(controller: _emailEC),
            const SizedBox(height: 16),
            TextFormField(controller: _passEC),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _controller.login(_emailEC.text, _passEC.text),
              child: Text(AppLocalizations.of(context)!.enter),
            ),
          ],
        ),
      ),
    );
  }
}
