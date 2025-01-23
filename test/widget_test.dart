import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/teachermodel.dart';
import 'package:mobile_be/pages/dashboard/dashboard_screen-sub-teac.dart';
import 'package:mobile_be/pages/dashboard/drawer-home-teacher.dart';
import 'package:mobile_be/pages/superadmin/admin-dashboard.dart';
import 'package:mobile_be/pages/superadmin/classes/class_screen.dart';
import 'package:mobile_be/pages/superadmin/teachers/teacher_screen.dart';
import 'package:mobile_be/services/teacher-service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'widget_test.mocks.dart';

@GenerateMocks([TeacherService])
void main() {
  testWidgets('SuperadminDashboard has Classroom text',
      (WidgetTester tester) async {
    // Build the SuperadminDashboard widget
    await tester.pumpWidget(MaterialApp(home: SuperadminDashboard()));

    // Find the "Classroom" text
    expect(find.text('Classroom'), findsOneWidget);

    // Tap the "Classroom" ListTile
    await tester.tap(find.text('Classroom'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Verify that ClassScreen is displayed
    expect(find.byType(ClassScreen), findsOneWidget);
  });
  testWidgets('SuperadminDashboard has Teacher text',
      (WidgetTester tester) async {
    // Build the SuperadminDashboard widget
    await tester.pumpWidget(MaterialApp(home: SuperadminDashboard()));

    expect(find.text('Teacher'), findsOneWidget);

    await tester.tap(find.text('Teacher'));
  });
  testWidgets('SuperadminDashboard has Student text',
      (WidgetTester tester) async {
    // Build the SuperadminDashboard widget
    await tester.pumpWidget(MaterialApp(home: SuperadminDashboard()));

    expect(find.text('Student'), findsOneWidget);

    await tester.tap(find.text('Classroom'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete
  });
  testWidgets('SuperadminDashboard has Grade text',
      (WidgetTester tester) async {
    // Build the SuperadminDashboard widget
    await tester.pumpWidget(MaterialApp(home: SuperadminDashboard()));

    expect(find.text('Grade'), findsOneWidget);
  });

  testWidgets('SuperadminDashboard has Announcements text',
      (WidgetTester tester) async {
    // Build the SuperadminDashboard widget
    await tester.pumpWidget(MaterialApp(home: SuperadminDashboard()));

    expect(find.text('Announcements'), findsOneWidget);
  });
  testWidgets('SuperadminDashboard has Subjects text',
      (WidgetTester tester) async {
    // Build the SuperadminDashboard widget
    await tester.pumpWidget(MaterialApp(home: SuperadminDashboard()));

    expect(find.text('Subjects'), findsOneWidget);
  });
  testWidgets('HomeroomTeacherDrawer has Dashboard text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DrawerHomeroomTeacher()));

    expect(find.text('Dashboard'), findsOneWidget);
  });
  testWidgets('HomeroomTeacherDrawer has Attendance text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DrawerHomeroomTeacher()));

    expect(find.text('Attendance'), findsOneWidget);
  });
  testWidgets('HomeroomTeacherDrawer has Announcements text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DrawerHomeroomTeacher()));

    expect(find.text('Announcements'), findsOneWidget);
  });
  testWidgets('HomeroomTeacherDrawer has Reports text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DrawerHomeroomTeacher()));

    expect(find.text('Reports'), findsOneWidget);
  });
}
