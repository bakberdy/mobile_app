import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:travel_app/src/core/utils/extensions/context_x.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/onboarding_bg.png', fit: .cover),
          ),
          Positioned(
            top: 120,
            right: 0,
            left: 0,
            bottom: 40,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Center(
                  child: Text(
                    'Aspen',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const .symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Plan your\n',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 24,
                            fontWeight: .w400,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        TextSpan(
                          text: 'Luxurious Vacation',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: .w600,
                            fontSize: 40,
                            height: 1.2,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: .symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 52,
                    width: .infinity,
                    child: FilledButton(
                      onPressed: () {},
                      child: Text('Explore'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
