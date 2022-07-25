import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieapp/%20core/failure.dart';
import 'package:movieapp/features/movie_flow/genre/genre.dart';
import 'package:movieapp/features/movie_flow/genre/genre_entity.dart';
import 'package:movieapp/features/movie_flow/movie_repository.dart';
import 'package:movieapp/features/movie_flow/movie_service.dart';
import 'package:movieapp/features/movie_flow/result/movie.dart';
import 'package:movieapp/features/movie_flow/result/movie_enity.dart';
import 'package:multiple_result/multiple_result.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository mockedMovieRepository;

  setUp(() {
    mockedMovieRepository = MockMovieRepository();
  });

  test('Given successful call When getting GenreEntities', () async {
    when(() => mockedMovieRepository.getMovieGenres()).thenAnswer(
        (invocation) =>
            Future.value([const GenreEntity(id: 0, name: 'Animation')]));

    final movieService = TMDBMovieService(mockedMovieRepository);
    final result = await movieService.getGenres();

    expect(result.getSuccess(), [Genre(name: 'Animation')]);
  });

  test('Gicen failed call When getting GenreEntities Then return failure',
      () async {
    when(() => mockedMovieRepository.getMovieGenres()).thenThrow(
        Failure(message: 'No internet', exception: const SocketException('')));
    final movieService = TMDBMovieService(mockedMovieRepository);

    final result = await movieService.getGenres();
    expect(result.getError()?.exception, isA<SocketException>());
  });

  test(
      'Given succesful call When getting MovieEntity Then map to correct Movie',
      () async {
    Genre genre = Genre(name: 'Animation', id: 1, isSelected: true);
    const movieEntity = MovieEntity(
        title: 'Lilo & Stich',
        overview: 'Some interesting story',
        voteAverage: 5.2,
        genreIds: [1],
        releaseDate: '2010-02-03');

    when(() => mockedMovieRepository.getRecommendedMovies(any(), any(), any()))
        .thenAnswer((invocation) {
      return Future.value([
        movieEntity,
      ]);
    });
    final MovieService = TMDBMovieService(mockedMovieRepository);

    final result =
        await MovieService.getRecommendedMovie(5, 20, [genre], DateTime(2021));
    final movie = result.getSuccess();
    expect(
        movie,
        Movie(
            title: movieEntity.title,
            overview: movieEntity.overview,
            voteAverage: movieEntity.voteAverage,
            genres: [genre],
            releaseDate: movieEntity.releaseDate));
  });

  test('Given failed call When getting MovieEntities Then return failure',
      () async {
    Genre genre = Genre(name: 'Animation', id: 1, isSelected: true);
    when(() => mockedMovieRepository.getRecommendedMovies(any(), any(), any()))
        .thenThrow(
            Failure(message: 'message', exception: const SocketException('')));
    final MovieService = TMDBMovieService(mockedMovieRepository);
    final result =
        await MovieService.getRecommendedMovie(5, 20, [genre], DateTime(2021));

    expect(result.getError()?.exception, isA<SocketException>());
  });
}
