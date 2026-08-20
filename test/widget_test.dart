import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/theme_cubit/theme_cubit.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/localization_service/localization_cubit/localization_cubit.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/customer_authentication_screen.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/layouts/customer_authentication_desktop.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/layouts/customer_authentication_mobile.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_card_widget.dart';
import 'package:mvvvm_template_with_basic_services/main.dart';

void main() {
  Widget buildTestApp() => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LocalizationCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
        ],
        child: const MyApp(),
      );

  testWidgets('Customer authentication renders mobile layout on small screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(CustomerAuthenticationScreen), findsOneWidget);
    expect(find.byType(CustomerAuthenticationMobile), findsOneWidget);
    expect(find.byType(CustomerAuthenticationDesktop), findsNothing);
    expect(find.byType(AuthCardWidget), findsOneWidget);
  });

  testWidgets('Customer authentication renders desktop layout on large screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(CustomerAuthenticationScreen), findsOneWidget);
    expect(find.byType(CustomerAuthenticationDesktop), findsOneWidget);
    expect(find.byType(CustomerAuthenticationMobile), findsNothing);
  });

  testWidgets('Toggle between Log In and Sign Up tabs', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Default is Log In
    expect(find.text('Log In'), findsWidgets);
    expect(find.text('Forgot?'), findsOneWidget);

    // Tap Sign Up tab
    await tester.tap(find.text('Sign Up').first);
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Forgot?'), findsNothing);
  });

  testWidgets('Validates login form with empty and invalid inputs', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Tap submit button with empty fields
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    // Enter invalid email and short password
    await tester.enterText(find.byType(TextFormField).at(0), 'invalidemail');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a valid email address'), findsOneWidget);
    expect(
      find.text('Password must be at least 6 characters'),
      findsOneWidget,
    );
  });

  testWidgets('Validates signup form with mismatched passwords', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Switch to Sign Up
    await tester.tap(find.text('Sign Up').first);
    await tester.pumpAndSettle();

    // Enter matching email and password, but mismatched confirm password
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'user@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'differentpassword',
    );
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Passwords do not match'), findsOneWidget);
  });
}
