import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/%20core/environment_variables.dart';
import 'package:movieapp/features/movie_flow/genre/genre_entity.dart';
import 'package:movieapp/features/movie_flow/result/movie_enity.dart';
import 'package:movieapp/main.dart';

final MovieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TMDBMovieRepository(dio: dio);
});

abstract class MovieRepository {
  Future<List<GenreEntity>> getMovieGenres();
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds);
}

class TMDBMovieRepository implements MovieRepository {
  TMDBMovieRepository({required this.dio});
  final Dio dio;

  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    final response = await dio.get('genre/movie/list',
        queryParameters: {'api_key': api, 'language': 'en-US'});
    final results = List<Map<String, dynamic>>.from(response.data['genres']);
    final genres = results.map((e) => GenreEntity.fromMap(e)).toList();

    return genres;
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genresIds) async {
    final response = await dio.get(
      'discover/movie',
      queryParameters: {
        'api_key': api,
        'language': 'en-US',
        'sort_by': 'popularity.desc',
        'include_adult': false,
        'vote_avarage.gte': rating,
        'page': 1,
        'release_date.gte': date,
        'with_genres': genresIds,
      },
    );
    final results = List<Map<String, dynamic>>.from(response.data['results']);
    final movies = results.map((e) => MovieEntity.fromMap(e)).toList();
    return movies;
  }
}
