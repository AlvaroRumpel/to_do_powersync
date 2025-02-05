import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/routes.dart';
import '../../../../shared/utils/context_extensions.dart';
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
        title: Text(context.localization.login),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (user) => context.pushReplacementNamed(HOME),
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(controller: _emailEC),
              const SizedBox(height: 16),
              TextFormField(controller: _passEC),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _controller.login(_emailEC.text, _passEC.text),
                child: Text(context.localization.enter),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pushNamed(REGISTER),
                child: Text(context.localization.create_account),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
