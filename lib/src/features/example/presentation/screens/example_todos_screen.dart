import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/components/buttons/base_filled_button.dart';
import 'package:mobile_app/src/components/buttons/base_outlined_button.dart';
import 'package:mobile_app/src/components/dialogs/base_dialog.dart';
import 'package:mobile_app/src/components/dialogs/base_snackbar.dart';
import 'package:mobile_app/src/config/di/injection.dart';
import 'package:mobile_app/src/config/router/app_router.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/core/bloc/state_status.dart';
import 'package:mobile_app/src/core/error/error.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/presentation/bloc/todos_bloc/example_todos_bloc.dart';
import 'package:mobile_app/src/features/example/presentation/widgets/todo_list.dart';

@RoutePage()
class ExampleTodosScreen extends StatelessWidget {
  const ExampleTodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ExampleTodosBloc>()..add(const ExampleTodosEvent.started()),
      child: const _ExampleTodosScreenContent(),
    );
  }
}

class _ExampleTodosScreenContent extends StatelessWidget {
  const _ExampleTodosScreenContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExampleTodosBloc, ExampleTodosState>(
      listenWhen: (prev, curr) => curr.failure != null && prev.failure != curr.failure,
      listener: _handleFailure,
      builder: (context, state) {
        final isLoading = state.status == StateStatus.loading;

        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.exampleTodosTitle)),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.l10n.todoListTitle,
                          style: context.textTheme.titleLarge,
                        ),
                      ),
                      BaseFilledButton.secondary(
                        onPressed: () => _openTodoEditor(context),
                        label: context.l10n.addTodo,
                        expand: false,
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.md),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                sliver: SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: BaseOutlinedButton.secondary(
                      onPressed: () => context.read<ExampleTodosBloc>().add(
                        const ExampleTodosEvent.refreshed(),
                      ),
                      label: context.l10n.refreshTodos,
                      expand: false,
                      loading: isLoading && state.todos.isEmpty,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.md),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                sliver: TodoList(
                  todos: state.todos,
                  isLoading: isLoading,
                  onEdit: (todo) => _openTodoEditor(context, todo: todo),
                  onToggle: (todo) => context.read<ExampleTodosBloc>().add(
                    ExampleTodosEvent.toggled(todo),
                  ),
                  onDelete: (id) => context.read<ExampleTodosBloc>().add(
                    ExampleTodosEvent.deleted(id),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleFailure(BuildContext context, ExampleTodosState state) {
    final failure = state.failure;
    if (failure == null) return;

    final message = failure.message ?? failure.defaultMessage(context);
    switch (failure.type) {
      case FailureType.snackbar:
        BaseSnackbar.error(context, message: message);
      case FailureType.banner:
        BaseDialog.showBanner(context, message: message);
      case FailureType.alert:
        BaseDialog.showBasic(
          context,
          title: context.l10n.errorTitle,
          description: message,
          primaryLabel: context.l10n.dismiss,
          barrierDismissible: false,
        );
      case FailureType.fullScreenError:
        BaseDialog.showFullscreen(
          context,
          title: context.l10n.errorTitle,
          bodyText: message,
          primaryLabel: context.l10n.refreshTodos,
          onPrimary: () => context.read<ExampleTodosBloc>().add(
            const ExampleTodosEvent.started(),
          ),
          barrierDismissible: false,
        );
      case FailureType.inlineError:
        break;
      case FailureType.silent:
        break;
    }
  }

  Future<void> _openTodoEditor(BuildContext context, {Todo? todo}) async {
    final didSave = await context.router.push<bool>(
      ExampleTodoEditorRoute(todo: todo),
    );
    if (didSave == true && context.mounted) {
      context.read<ExampleTodosBloc>().add(const ExampleTodosEvent.refreshed());
    }
  }
}
