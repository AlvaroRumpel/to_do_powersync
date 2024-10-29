import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/routes.dart';
import '../../../../shared/utils/context_extensions.dart';
import '../bloc/register_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailEC = TextEditingController();
  final _passEC = TextEditingController();
  late final _controller = context.read<RegisterCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.create_account),
      ),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          state.whenOrNull(success: () => context.goNamed(HOME));
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
                onPressed: () =>
                    _controller.createAccount(_emailEC.text, _passEC.text),
                child: Text(context.localization.enter),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
