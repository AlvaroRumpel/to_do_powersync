import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/routes.dart';
import '../bloc/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskEC = TextEditingController();
  late final _controller = context.read<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await _controller.logout();

              if (context.mounted) {
                context.goNamed(LOGIN);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverList.list(
                  children: [
                    TextFormField(controller: _taskEC),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _controller.createToDo(_taskEC.text),
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
                state.maybeWhen(
                  data: (toDos) => SliverList.builder(
                    itemCount: toDos.length,
                    itemBuilder: (_, index) {
                      final toDo = toDos[index];

                      return ListTile(
                        title: Text(toDo.task),
                      );
                    },
                  ),
                  orElse: () => const SliverToBoxAdapter(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
