import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/screens/menu_screen.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  group('App tests', () {
    testWidgets('App displays MovieScreen as home',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      expect(find.byType(MovieScreen), findsOneWidget);
      expect(find.text(appTitle), findsOneWidget);
    });

    testWidgets('Home page displays the movie titles',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      expect(find.byType(MovieCard), findsNWidgets(2));
      expect(
        find.text('Interstellar (PG-13)', findRichText: true),
        findsOneWidget,
      );
      expect(
        find.text('Harry Potter and the Prisoner of Azkaban (PG)',
            findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('Home page displays the booking buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      expect(find.text('BOOK NOW'), findsNWidgets(2));
    });

    testWidgets(
        'tapping book now navigates to MovieListing with a selected movie',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Interstellar (2014) (PG-13)'), findsOneWidget);
      expect(find.text('Adults (£10.00)'), findsOneWidget);

      await tester.tap(find.text('ADD TO ORDER'));
      await tester.pump();

      expect(find.text('0 adult tickets added to order'), findsOneWidget);
    });
  });
}
