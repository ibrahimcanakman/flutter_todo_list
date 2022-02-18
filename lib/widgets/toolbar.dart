import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list/providers/all_provider.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);

  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black38;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          onCompletedTodoCount == 0
              ? 'Tüm görevler OK'
              : onCompletedTodoCount.toString() + ' görev tamamlanmadı',
          overflow: TextOverflow.ellipsis,
        )),
        Tooltip(
          message: 'All todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeTextColor(TodoListFilter.all)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.all;
              },
              child: const Text('All')),
        ),
        Tooltip(
          message: 'Active todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeTextColor(TodoListFilter.active)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.active;
              },
              child: const Text('Active')),
        ),
        Tooltip(
          message: 'Completed todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeTextColor(TodoListFilter.completed)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.completed;
              },
              child: const Text('Completed')),
        ),
      ],
    );
  }
}
