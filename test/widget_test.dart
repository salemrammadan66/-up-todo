import 'package:flutter_test/flutter_test.dart';

import 'package:up_todo/main.dart';

void main() {
  testWidgets('App starts and shows splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const UpTodoApp());

    // Splash screen shows the app name
    expect(find.text('UpTodo'), findsOneWidget);
  });
}