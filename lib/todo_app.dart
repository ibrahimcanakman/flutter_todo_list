import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list/providers/all_provider.dart';
import 'package:flutter_todo_list/widgets/title.dart';
import 'package:flutter_todo_list/widgets/todo_list_item.dart';
import 'package:flutter_todo_list/widgets/toolbar.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration:
                const InputDecoration(labelText: 'Neler yapacaksın bugün ?'),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
              newTodoController.text = '';
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          _allTodos.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    const Text(
                      'Bu koşullarda bir görev yok...',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                )
              : const SizedBox(),
          for (int i = 0; i < _allTodos.length; i++)
            Dismissible(
                key: ValueKey(_allTodos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(_allTodos[i]);
                },
                child: ProviderScope(overrides: [
                  currentTodoProvider.overrideWithValue(_allTodos[i]),
                ], child: const TodoListItemWidget()))
        ],
      ),
    );
  }
}
