import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/presentation/widgets/todo_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
    required this.isLoading,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
  });

  final List<Todo> todos;
  final bool isLoading;
  final ValueChanged<Todo> onEdit;
  final ValueChanged<Todo> onToggle;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    if (isLoading && todos.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (todos.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            context.l10n.noTodosYet,
            style: context.textTheme.bodyLarge,
          ),
        ),
      );
    }

    final formatter = DateFormat.yMd(context.languageCode).add_Hm();

    return SliverList.separated(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListItem(
          todo: todo,
          createdAtLabel: formatter.format(todo.createdAt),
          editLabel: context.l10n.editTodo,
          deleteLabel: context.l10n.deleteTodo,
          toggleLabel: todo.isDone
              ? context.l10n.markTodoUndone
              : context.l10n.markTodoDone,
          isLoading: isLoading,
          onEdit: () => onEdit(todo),
          onToggle: () => onToggle(todo),
          onDelete: () => onDelete(todo.id),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
    );
  }
}
