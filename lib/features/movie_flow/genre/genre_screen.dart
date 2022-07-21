import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/%20core/constants.dart';
import 'package:movieapp/%20core/widgets/primary_button.dart';
import 'package:movieapp/features/movie_flow/genre/genre.dart';
import 'package:movieapp/features/movie_flow/genre/list_card.dart';
import 'package:movieapp/features/movie_flow/movie_flow_controller.dart';

class GenreScreen extends ConsumerWidget {
  const GenreScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed:
                ref.read(MovieFlowControllerProvider.notifier).previousPage),
      ),
      body: Center(
        child: Column(children: [
          Text(
            'Lets\'s start with a genre',
            style: theme.textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ref.watch(MovieFlowControllerProvider).genres.when(
                  data: (genres) {
                    return ListView.separated(
                      itemCount: genres.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: kListItemSpacing),
                      itemBuilder: (context, index) {
                        final genre = genres[index];
                        return ListCaerd(
                          genre: genre,
                          onTap: () => ref
                              .read(MovieFlowControllerProvider.notifier)
                              .toggleSelected(genre),
                        );
                      },
                      separatorBuilder: ((context, index) {
                        return SizedBox(
                          height: kListItemSpacing,
                        );
                      }),
                    );
                  },
                  error: (e, s) {
                    return const Text('Something went wrong from our end');
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ),
          PrimaryButton(
              onPressed:
                  ref.read(MovieFlowControllerProvider.notifier).nextPage,
              text: 'Continue'),
          const SizedBox(
            height: kMediumSpacing,
          )
        ]),
      ),
    );
  }
}
