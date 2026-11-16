import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

const Movie testMovie1 = Movie(
  id: 'test_movie_1',
  name: 'Test Movie 1',
  ageRating: 'PG',
  publishedYear: 2020,
  description: 'First test movie.',
  imagePath: 'assets/images/test1.jpg',
  ticketPrice: 1000,
  screenings: ['Monday 1st Jan 2026, 18:00'],
);

const Movie testMovie2 = Movie(
  id: 'test_movie_2',
  name: 'Test Movie 2',
  ageRating: '12A',
  publishedYear: 2021,
  description: 'Second test movie.',
  imagePath: 'assets/images/test2.jpg',
  ticketPrice: 600,
  screenings: ['Tuesday 2nd Jan 2026, 20:00'],
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  group('BasketRepository tests', () {
    test('starts with an empty basket and zero total', () {
      final BasketRepository basket = BasketRepository.instance;
      expect(basket.getItems().length, 0);
      expect(basket.getTotal(), 0);
    });

    test('adds items and calculates the total correctly', () {
      final BasketRepository basket = BasketRepository.instance;
      const BasketItem item1 = BasketItem(movie: testMovie1, quantity: 2);
      const BasketItem item2 = BasketItem(movie: testMovie2, quantity: 1);

      basket.addItem(item1);
      basket.addItem(item2);

      expect(basket.getItems().length, 2);
      expect(basket.getTotal(), 2600);
    });

    test('removes items correctly', () {
      final BasketRepository basket = BasketRepository.instance;
      const BasketItem item = BasketItem(movie: testMovie1, quantity: 1);
      basket.addItem(item);
      expect(basket.getItems().length, 1);

      basket.removeItem(0);
      expect(basket.getItems().length, 0);
      expect(basket.getTotal(), 0);
    });

    test('clears all items', () {
      final BasketRepository basket = BasketRepository.instance;
      basket.addItem(const BasketItem(movie: testMovie1, quantity: 2));
      basket.addItem(const BasketItem(movie: testMovie2, quantity: 3));

      basket.clear();
      expect(basket.getItems().length, 0);
      expect(basket.getTotal(), 0);
    });
  });
}
