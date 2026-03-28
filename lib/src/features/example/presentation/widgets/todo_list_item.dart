import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/buttons/base_filled_button.dart';
import 'package:mobile_app/src/components/buttons/base_outlined_button.dart';
import 'package:mobile_app/src/config/theme/app_radii.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.createdAtLabel,
    required this.editLabel,
    required this.deleteLabel,
    required this.toggleLabel,
    required this.isLoading,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
  });

  final Todo todo;
  final String createdAtLabel;
  final String editLabel;
  final String deleteLabel;
  final String toggleLabel;
  final bool isLoading;
  final VoidCallback onEdit;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        border: Border.all(
          color: todo.isDone
              ? context.colorScheme.primary.withValues(alpha: 0.4)
              : context.colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.title, style: context.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(todo.description, style: context.textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              createdAtLabel,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                BaseOutlinedButton.secondary(
                  onPressed: isLoading ? null : onEdit,
                  label: editLabel,
                  expand: false,
                ),
                BaseOutlinedButton.secondary(
                  onPressed: isLoading ? null : onToggle,
                  label: toggleLabel,
                  expand: false,
                ),
                BaseFilledButton.secondary(
                  onPressed: isLoading ? null : onDelete,
                  label: deleteLabel,
                  expand: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
