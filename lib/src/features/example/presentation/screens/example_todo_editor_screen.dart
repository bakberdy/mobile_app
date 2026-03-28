import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/components/buttons/base_filled_button.dart';
import 'package:mobile_app/src/components/dialogs/base_dialog.dart';
import 'package:mobile_app/src/components/dialogs/base_snackbar.dart';
import 'package:mobile_app/src/config/di/injection.dart';
import 'package:mobile_app/src/config/theme/app_radii.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/core/bloc/state_status.dart';
import 'package:mobile_app/src/core/error/error.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/presentation/bloc/todo_editor_bloc/example_todo_editor_bloc.dart';

@RoutePage()
class ExampleTodoEditorScreen extends StatelessWidget {
  const ExampleTodoEditorScreen({super.key, this.todo});

  final Todo? todo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ExampleTodoEditorBloc>()
            ..add(ExampleTodoEditorEvent.started(todo)),
      child: const _ExampleTodoEditorScreenContent(),
    );
  }
}

class _ExampleTodoEditorScreenContent extends StatelessWidget {
  const _ExampleTodoEditorScreenContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExampleTodoEditorBloc, ExampleTodoEditorState>(
      listenWhen: (prev, curr) =>
          (curr.failure != null && prev.failure != curr.failure) ||
          (prev.status != StateStatus.success &&
              curr.status == StateStatus.success),
      listener: (context, state) {
        final failure = state.failure;
        if (failure != null) {
          _handleFailure(context, failure);
        }

        if (state.status == StateStatus.success) {
          context.router.maybePop(true);
        }
      },
      builder: (context, state) {
        final isEditing = state.todo != null;
        final isLoading = state.status == StateStatus.loading;
        final isSubmitDisabled =
            isLoading || state.status == StateStatus.success;
        final createdAt = state.createdAt ?? DateTime.now();
        final dateLabel = DateFormat.yMMMMd(
          context.languageCode,
        ).format(createdAt);
        final canSubmit =
            state.titleField.value.trim().isNotEmpty &&
            state.descriptionField.value.trim().isNotEmpty;

        return PopScope(
          canPop: !isLoading,
          child: Scaffold(
            backgroundColor: context.colorScheme.surface,
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.all(AppSpacing.md),
              child: BaseFilledButton.primary(
                onPressed: canSubmit && !isSubmitDisabled
                    ? () => context.read<ExampleTodoEditorBloc>().add(
                        const ExampleTodoEditorEvent.submitted(),
                      )
                    : null,
                label: isEditing
                    ? context.l10n.updateTodo
                    : context.l10n.addTodo,
                loading: isLoading,
                borderRadius: BorderRadius.circular(AppRadii.xl),
              ),
            ),
            body: Stack(
              children: [
                Positioned(
                  top: 96,
                  left: -56,
                  child: _buildGlowBubble(
                    context.colorScheme.primary.withValues(alpha: 0.08),
                  ),
                ),
                Positioned(
                  top: 244,
                  right: -72,
                  child: _buildGlowBubble(
                    context.colorScheme.tertiary.withValues(alpha: 0.08),
                  ),
                ),
                Positioned(
                  bottom: 120,
                  left: -64,
                  child: _buildGlowBubble(
                    context.colorScheme.secondary.withValues(alpha: 0.08),
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          isEditing
                              ? context.l10n.editTodo
                              : context.l10n.addTodo,
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _buildInputCard(
                          context,
                          icon: Icons.work_rounded,
                          iconBackground: context.colorScheme.primaryContainer,
                          label: context.l10n.todoTitleLabel,
                          child: TextFormField(
                            key: ValueKey('editor-title-${state.formVersion}'),
                            initialValue: state.titleField.value,
                            onChanged: (value) =>
                                context.read<ExampleTodoEditorBloc>().add(
                                  ExampleTodoEditorEvent.titleChanged(value),
                                ),
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: context.l10n.todoTitleLabel,
                              errorText: state.titleField.error,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _buildLargeCard(
                          context,
                          label: context.l10n.todoDescriptionLabel,
                          child: TextFormField(
                            key: ValueKey(
                              'editor-description-${state.formVersion}',
                            ),
                            initialValue: state.descriptionField.value,
                            onChanged: (value) =>
                                context.read<ExampleTodoEditorBloc>().add(
                                  ExampleTodoEditorEvent.descriptionChanged(
                                    value,
                                  ),
                                ),
                            maxLines: 4,
                            style: context.textTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: context.l10n.todoDescriptionLabel,
                              errorText: state.descriptionField.error,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _buildInputCard(
                          context,
                          icon: Icons.calendar_month_rounded,
                          iconBackground:
                              context.colorScheme.secondaryContainer,
                          label: context.l10n.createdAtLabel,
                          child: Text(
                            dateLabel,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _buildInputCard(
                          context,
                          label: context.l10n.todoDoneLabel,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Switch.adaptive(
                              value: state.isDoneField.value,
                              onChanged: (value) =>
                                  context.read<ExampleTodoEditorBloc>().add(
                                    ExampleTodoEditorEvent.doneChanged(value),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputCard(
    BuildContext context, {
    IconData? icon,
    Color? iconBackground,
    required String label,
    required Widget child,
  }) {
    return DecoratedBox(
      decoration: _cardDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null && iconBackground != null) ...[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  child: Icon(
                    icon,
                    size: 18,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeCard(
    BuildContext context, {
    required String label,
    required Widget child,
  }) {
    return DecoratedBox(
      decoration: _cardDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            child,
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(AppRadii.lg - 1),
      boxShadow: [
        BoxShadow(
          color: context.colorScheme.shadow.withValues(alpha: 0.04),
          blurRadius: 32,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildGlowBubble(Color color) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: color, blurRadius: 120, spreadRadius: 48),
          ],
        ),
        child: const SizedBox.square(dimension: 32),
      ),
    );
  }

  void _handleFailure(BuildContext context, Failure failure) {
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
          primaryLabel: context.l10n.dismiss,
          barrierDismissible: false,
        );
      case FailureType.inlineError:
        break;
      case FailureType.silent:
        break;
    }
  }
}
