import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('creates Movie instance with properties', () {
      const movie = Movie(
        id: 'test-movie',
        name: 'Test Movie',
        ageRating: 'PG',
        publishedYear: 2024,
        description: 'A movie used for testing.',
        imagePath: 'assets/images/test.jpg',
        ticketPrice: 1000,
        screenings: ['Monday 7pm', 'Tuesday 8pm'],
      );

      expect(movie.id, 'test-movie');
      expect(movie.name, 'Test Movie');
      expect(movie.ageRating, 'PG');
      expect(movie.publishedYear, 2024);
      expect(movie.description, 'A movie used for testing.');
      expect(movie.imagePath, 'assets/images/test.jpg');
      expect(movie.ticketPrice, 1000);
      expect(movie.screenings, ['Monday 7pm', 'Tuesday 8pm']);
    });

    test('formattedPrice returns correct format', () {
      const movie = Movie(
        id: 'test-movie',
        name: 'Test Movie',
        ageRating: 'PG',
        publishedYear: 2024,
        description: 'A movie used for testing.',
        imagePath: 'assets/images/test.jpg',
        ticketPrice: 600,
        screenings: [],
      );

      expect(movie.formattedPrice, '£6.00');
    });

    test('Check U rated movie access for child and adults', () {
      const movie = Movie(
        id: 'test-movie',
        name: 'Test Movie',
        ageRating: 'U',
        publishedYear: 2024,
        description: 'A movie used for testing.',
        imagePath: 'assets/images/test.jpg',
        ticketPrice: 1000,
        screenings: [],
      );

      expect(movie.isChildFriendly, true);
      expect(movie.isAdultOnly, false);
    });

    test('Check U rated movie access only for adults', () {
      const movie = Movie(
        id: 'test-movie',
        name: 'Test Movie',
        ageRating: 'PG',
        publishedYear: 2024,
        description: 'A movie used for testing.',
        imagePath: 'assets/images/test.jpg',
        ticketPrice: 1000,
        screenings: [],
      );

      expect(movie.isChildFriendly, true);
      expect(movie.isAdultOnly, false);
    });

    test('Check 15 rated movie access for adult and not child', () {
      const movie = Movie(
        id: 'test-movie',
        name: 'Test Movie',
        ageRating: '15',
        publishedYear: 2024,
        description: 'A movie used for testing.',
        imagePath: 'assets/images/test.jpg',
        ticketPrice: 1000,
        screenings: [],
      );

      expect(movie.isChildFriendly, false);
      expect(movie.isAdultOnly, false);
    });

    test('Check 18 rated movie access for adult only and not child', () {
      const movie = Movie(
        id: 'test-movie',
        name: 'Test Movie',
        ageRating: '18',
        publishedYear: 2024,
        description: 'A movie used for testing.',
        imagePath: 'assets/images/test.jpg',
        ticketPrice: 1000,
        screenings: [],
      );

      expect(movie.isChildFriendly, false);
      expect(movie.isAdultOnly, true);
    });
  });
}
