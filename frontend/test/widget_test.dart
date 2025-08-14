import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('Login Screen form test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Find the email and password fields and the login button.
    final emailField = find.byType(TextField).at(0); // Assuming email field is the first TextField
    final passwordField = find.byType(TextField).at(1); // Assuming password field is the second TextField
    final loginButton = find.byType(ElevatedButton);

    // Verify that the email and password fields are present.
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Simulate entering text into the email and password fields.
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');

    // Verify the entered text in email and password fields.
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);

    // Tap the login button.
    await tester.tap(loginButton);

    // Trigger a frame to let the interaction take place.
    await tester.pump();

    // Now, you can verify if the login action happens as expected.
    // You can either check for navigation to another screen or a success message.
    // Assuming your app shows 'Login successful' text after successful login:
    expect(find.text('Login successful'), findsOneWidget);  // Or any other expected result after login
  });
}
