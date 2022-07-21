import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/%20core/constants.dart';
import 'package:movieapp/%20core/widgets/primary_button.dart';
import 'package:movieapp/features/movie_flow/movie_flow.dart';
import 'package:movieapp/features/movie_flow/movie_flow_controller.dart';
import 'package:movieapp/features/movie_flow/result/result_screen.dart';

class YearsBackScreen extends ConsumerWidget {
  const YearsBackScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed:
              ref.watch(MovieFlowControllerProvider.notifier).previousPage,
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            'How many years back should we check for?',
            style: theme.textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${ref.watch(MovieFlowControllerProvider).yearsBack}',
                style: theme.textTheme.headline2,
              ),
              Text(
                'Years back',
                style: theme.textTheme.headline2?.copyWith(
                    color: theme.textTheme.headline4?.color?.withOpacity(0.62)),
              )
            ],
          ),
          const Spacer(),
          Slider(
            label: '${ref.watch(MovieFlowControllerProvider).yearsBack}',
            divisions: 70,
            min: 0,
            max: 70,
            value: ref.watch(MovieFlowControllerProvider).yearsBack.toDouble(),
            onChanged: (value) {
              ref
                  .read(MovieFlowControllerProvider.notifier)
                  .updateYearsBack(value.toInt());
            },
          ),
          const Spacer(),
          PrimaryButton(
              onPressed: () async {
                await ref
                    .read(MovieFlowControllerProvider.notifier)
                    .getRecommendedMovie();
                Navigator.of(context).push(ResultScreen.route());
              },
              isLoading:
                  ref.watch(MovieFlowControllerProvider).movie is AsyncLoading,
              text: 'Amazing'),
          const SizedBox(height: kMediumSpacing)
        ],
      )),
    );
  }
}
