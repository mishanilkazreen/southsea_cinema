import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/screens/settings_screen.dart';

void main() {
  testWidgets('SettingsScreen displays the form fields switch and buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    expect(find.text('MY SETTINGS'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('SAVE SETTINGS'), findsOneWidget);
  });

  testWidgets('Toggling the switch and saving settings shows confirmation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    final Finder switchFinder = find.byType(Switch);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    await tester.tap(switchFinder);
    await tester.pump();
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pump();

    expect(find.text('Your settings have been saved.'), findsOneWidget);
  });

  testWidgets('Tapping cancel clears the form', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    final Finder emailField =
        find.widgetWithText(TextField, 'Enter your email');
    await tester.enterText(emailField, 'johndoe@gmail.com');
    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(find.text('johndoe@gmail.com'), findsOneWidget);

    await tester.tap(find.text('CANCEL'));
    await tester.pump();

    expect(find.text('johndoe@gmail.com'), findsNothing);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
  });
}
