import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/localization_service/localization_cubit/localization_cubit.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/customer_authentication_screen.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/layouts/customer_authentication_desktop.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/layouts/customer_authentication_mobile.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/widgets/auth_card_widget.dart';
import 'package:mvvvm_template_with_basic_services/main.dart';

void main() {
  testWidgets('Customer authentication renders mobile layout on small screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => LocalizationCubit(),
        child: const MyApp(),
      ),
    );
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

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => LocalizationCubit(),
        child: const MyApp(),
      ),
    );
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

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => LocalizationCubit(),
        child: const MyApp(),
      ),
    );
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
}
