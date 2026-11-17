import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/screens/basket_screen.dart';

const Movie testMovie = Movie(
  id: 'test_movie',
  name: 'Test Movie',
  ageRating: 'PG',
  publishedYear: 2020,
  description: 'A test movie.',
  imagePath: 'assets/images/interstellar.jpg',
  ticketPrice: 1000,
  screenings: ['Monday 1st Jan 2026, 18:00'],
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  testWidgets('BasketScreen displays empty message when basket has no items', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: BasketScreen()));

    expect(find.text('The basket is empty'), findsOneWidget);
    expect(find.text('BUY TICKETS'), findsNothing);
  });

  testWidgets(
    'BasketScreen renders items and removes item when remove pressed',
    (WidgetTester tester) async {
      const BasketItem item = BasketItem(movie: testMovie, quantity: 2);
      BasketRepository.instance.addItem(item);

      await tester.pumpWidget(const MaterialApp(home: BasketScreen()));

      expect(find.text('MY ORDER'), findsOneWidget);
      expect(find.text('2 tickets'), findsOneWidget);
      expect(find.textContaining('Test Movie'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£4.00'), findsOneWidget);
      expect(find.text('£24.00'), findsOneWidget);
      expect(find.text('BUY TICKETS'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pump();

      expect(find.text('The basket is empty'), findsOneWidget);
    },
  );

  testWidgets('Tapping buy tickets clears the basket and shows confirmation', (
    WidgetTester tester,
  ) async {
    const BasketItem item = BasketItem(movie: testMovie, quantity: 1);
    BasketRepository.instance.addItem(item);

    await tester.pumpWidget(const MaterialApp(home: BasketScreen()));

    await tester.tap(find.text('BUY TICKETS'));
    await tester.pump();

    expect(BasketRepository.instance.getItems(), isEmpty);
    expect(find.text('The basket is empty'), findsOneWidget);
    expect(find.text('Your tickets have been purchased.'), findsOneWidget);
  });
}
