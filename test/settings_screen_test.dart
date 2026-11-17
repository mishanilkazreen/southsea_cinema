import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/screens/settings_screen.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('SettingsScreen displays the form fields switch and buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('MY SETTINGS'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('SAVE SETTINGS'), findsOneWidget);
  });

  testWidgets('SettingsScreen pre-fills saved settings on open', (
    WidgetTester tester,
  ) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(<String, Object>{
      prefAddress: '123 Alphabet Road',
      prefEmail: 'johndoe@gmail.com',
      prefPatronNumber: '12345',
      prefReceiveNews: true,
    });

    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('123 Alphabet Road'), findsOneWidget);
    expect(find.text('johndoe@gmail.com'), findsOneWidget);
    expect(find.text('12345'), findsOneWidget);
    final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, isTrue);
  });

  testWidgets('Toggling the switch and saving settings stores the values', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();

    final Finder addressField =
        find.widgetWithText(TextField, 'Enter your address');
    final Finder emailField =
        find.widgetWithText(TextField, 'Enter your email');
    final Finder patronNumberField =
        find.widgetWithText(TextField, 'Enter your patron number');

    await tester.enterText(addressField, '123 Alphabet Road');
    await tester.enterText(emailField, 'johndoe@gmail.com');
    await tester.enterText(patronNumberField, '12345');

    final Finder switchFinder = find.byType(Switch);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    await tester.tap(switchFinder);
    await tester.pump();
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pumpAndSettle();

    expect(find.text('Your settings have been saved.'), findsOneWidget);

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    expect(await prefs.getString(prefAddress), '123 Alphabet Road');
    expect(await prefs.getString(prefEmail), 'johndoe@gmail.com');
    expect(await prefs.getString(prefPatronNumber), '12345');
    expect(await prefs.getBool(prefReceiveNews), isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();
    expect(find.text('123 Alphabet Road'), findsOneWidget);
    expect(find.text('johndoe@gmail.com'), findsOneWidget);
    expect(find.text('12345'), findsOneWidget);
    final Switch reopenedSwitch = tester.widget<Switch>(find.byType(Switch));
    expect(reopenedSwitch.value, isTrue);
  });

  testWidgets('Tapping cancel clears the form', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();

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
