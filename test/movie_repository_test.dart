import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository unit tests', () {
    test('getMovies returns at least two movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, greaterThanOrEqualTo(2));
    });

    test('every movie has valid details', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      for (final Movie movie in movies) {
        expect(movie.id, isNotEmpty);
        expect(movie.name, isNotEmpty);
        expect(movie.ageRating, isNotEmpty);
        expect(movie.ticketPrice, greaterThan(0));
      }
    });

    test('every movie has a unique id', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();
      final List<String> seenIds = [];

      for (final Movie movie in movies) {
        expect(seenIds.contains(movie.id), false);
        seenIds.add(movie.id);
      }
    });

    test('getMovieById returns matching movie when id exists', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('interstellar');

      expect(movie, isNotNull);
      expect(movie?.name, 'Interstellar');
      expect(movie?.ticketPrice, 1000);
    });

    test('getMovieById returns null when id does not exist', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('na');

      expect(movie, isNull);
    });

    test('getMoviesByAgeRating returns only movies with that rating', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMoviesByAgeRating('PG');

      expect(movies, isNotEmpty);
      for (final Movie movie in movies) {
        expect(movie.ageRating, 'PG');
      }
    });

    test('getMoviesByAgeRating returns empty list when no movie matches', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMoviesByAgeRating('18');

      expect(movies, isEmpty);
    });

    test('getMoviesUnderPrice returns only movies at or under the price', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMoviesUnderPrice(10.00);

      expect(movies, isNotEmpty);
      for (final Movie movie in movies) {
        expect(movie.ticketPrice, lessThanOrEqualTo(1000));
      }
    });

    test('getMoviesUnderPrice returns empty list when price is too low', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMoviesUnderPrice(5.00);

      expect(movies, isEmpty);
    });
  });
}
