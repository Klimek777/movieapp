import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieapp/features/movie_flow/genre/genre.dart';
import 'package:movieapp/features/movie_flow/movie_flow_controller.dart';
import 'package:movieapp/features/movie_flow/movie_service.dart';
import 'package:movieapp/features/movie_flow/years_back/years_back_screen.dart';
import 'package:multiple_result/multiple_result.dart';

class MockMovieService extends Mock implements MovieService {}

void main() {
  late MovieService mockedMovieService;
  late ProviderContainer container;
  late Genre genre;

  setUp(() {
    mockedMovieService = MockMovieService();
    container = ProviderContainer(overrides: [
      movieServiceProvider.overrideWithValue(mockedMovieService),
    ]);
    genre = Genre(name: 'Animation');
    when(() => mockedMovieService.getGenres()).thenAnswer(
      (invocation) => Future.value(
        Success([genre]),
      ),
    );
  });
  tearDown(() {
    container.dispose();
  });
  group('MovieFlowControllerTests -', () {
    test('Given genres When Toggle Then that genre should be toggled',
        () async {
      await container
          .read(MovieFlowControllerProvider.notifier)
          .stream
          .firstWhere((state) => state.genres is AsyncData);
      container
          .read(MovieFlowControllerProvider.notifier)
          .toggleSelected(genre);

      final toggledGenre = genre.toggleSelected();
      expect(container.read(MovieFlowControllerProvider).genres.value,
          [toggledGenre]);
    });
    for (final rating in [0, 7, 10, 2, -2]) {
      test(
          'Given different ratings Whe updating rating with $rating Then that should be represented',
          () async {
        container
            .read(MovieFlowControllerProvider.notifier)
            .updateRating(rating);
        expect(container.read(MovieFlowControllerProvider).rating, rating);
      });
    }
    for (final yearsBack in [0, 7, 70, 2, -2]) {
      test(
          'Given different yearsback When updating yearsBack with $yearsBack Then that should be represented',
          () async {
        container
            .read(MovieFlowControllerProvider.notifier)
            .updateYearsBack(yearsBack);
        expect(
            container.read(MovieFlowControllerProvider).yearsBack, yearsBack);
      });
    }
  });
}
