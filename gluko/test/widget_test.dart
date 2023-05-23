// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gluko/Begin/view/begin_page.dart';
import 'package:gluko/assembleplate/view/assembleplate_page.dart';
import 'package:gluko/calculateinsulin/view/calculateinsulina_page.dart';
import 'package:gluko/emergency/view/emergency_page.dart';
import 'package:gluko/forgetpassword/view/forgetpassword_page.dart';
import 'package:gluko/home/view/home_page.dart';
import 'package:gluko/login/view/login_page.dart';

import 'package:gluko/main.dart';
import 'package:gluko/profile/view/profile_page.dart';
import 'package:gluko/recommendePlate/view/recommendPlate_page.dart';
import 'package:gluko/report/view/report_page.dart';
import 'package:gluko/singup/view/singup_page.dart';
import 'package:gluko_repository/gluko_repository.dart';

void main() {
  testWidgets('test Loginpage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: Loginpage(),
    ));
  });
  testWidgets('test Singuppage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: Singuppage(),
    ));
  });
  testWidgets('test forgetpasswordpage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: forgetpasswordpage(),
    ));
  });
  testWidgets('test HomePage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: HomePage(),
    ));
  });
  testWidgets('test beginpage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: beginpage(),
    ));
  });
  testWidgets('test reportpage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: reportpage(),
    ));
  });testWidgets('test emergencypage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: emergencypage(),
    ));
  });testWidgets('test profilepage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: profilepage(),
    ));
  });testWidgets('test assembleplatepage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: assembleplatepage(),
    ));
  });testWidgets('test calculateinsuline_page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: calculateinsuline_page(info: DetailInsulin(120, "110", 120, 200), foods: [],),
    ));
  });
  testWidgets('test RecomemendePlatepage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MaterialApp(
      home: RecomemendePlatepage(PlateRecomend([],10,10,10,10,"",10,10,"","",1))
    ));
  });
}
