import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/%20core/constants.dart';
import 'package:movieapp/%20core/widgets/primary_button.dart';
import 'package:movieapp/features/movie_flow/movie_flow_controller.dart';

class RatingScreen extends ConsumerWidget {
  const RatingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed:
              ref.read(MovieFlowControllerProvider.notifier).previousPage,
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            'Select a minimum rating\nranging from 1-10',
            style: theme.textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${ref.watch(MovieFlowControllerProvider).rating}',
                style: theme.textTheme.headline2,
              ),
              const Icon(
                Icons.star_rounded,
                color: Colors.amber,
                size: 62,
              )
            ],
          ),
          const Spacer(),
          Slider(
            label: '${ref.watch(MovieFlowControllerProvider).rating}',
            divisions: 10,
            min: 1,
            max: 10,
            value: ref.watch(MovieFlowControllerProvider).rating.toDouble(),
            onChanged: (value) {
              ref
                  .read(MovieFlowControllerProvider.notifier)
                  .updateRating(value.toInt());
            },
          ),
          const Spacer(),
          PrimaryButton(
              onPressed:
                  ref.watch(MovieFlowControllerProvider.notifier).nextPage,
              text: 'Yes please'),
          const SizedBox(
            height: kMediumSpacing,
          )
        ],
      )),
    );
  }
}
