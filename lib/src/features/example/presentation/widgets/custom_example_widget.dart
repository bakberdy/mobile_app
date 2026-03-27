import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/buttons/base_filled_button.dart';
import 'package:mobile_app/src/config/theme/app_radii.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';

class CustomExampleWidget extends StatelessWidget {
  const CustomExampleWidget({
    super.key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
  });
  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.xxl),
        image: DecorationImage(
          image: context.assets.images.onboardingBg.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          ClipRect(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.colorScheme.primaryContainer.withValues(alpha: 0.0),
                    context.colorScheme.primaryContainer.withValues(alpha: 0.4),
                    context.colorScheme.primaryContainer.withValues(alpha: 0.6),
                    context.colorScheme.primaryContainer.withValues(alpha: 0.8),
                    context.colorScheme.primaryContainer.withValues(alpha: 0.6),
                    context.colorScheme.primaryContainer.withValues(alpha: 0.4),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: .w600,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      description,
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BaseFilledButton.primary(
                      onPressed: () {},
                      label: context.l10n.continueToLogin,
                      borderRadius: BorderRadius.circular(AppRadii.xl),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
