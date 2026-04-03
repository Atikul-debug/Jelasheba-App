import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:jelasheba/main.dart';
import 'package:jelasheba/core/providers/app_provider.dart';

void main() {
  testWidgets('App launches', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppProvider(),
        child: const JelashebaApp(),
      ),
    );
    expect(find.text('জেলাশেবা'), findsOneWidget);
  });
}
