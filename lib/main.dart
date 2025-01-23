import 'package:flutter/material.dart';
import 'package:mobile_be/pages/authentication/choose_role_screen.dart';
import 'package:mobile_be/pages/authentication/choose_teacher_role.dart';
import 'package:mobile_be/pages/dashboard/dashboard_screen-student.dart';
import 'package:mobile_be/pages/dashboard/dashboard_screen-sub-teac.dart';
import 'package:mobile_be/pages/report/grade_report.dart';
import 'package:mobile_be/pages/report/student_report.dart';
import 'package:mobile_be/pages/schedules/schedulescreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_be/l10n/l10n.dart';
import 'package:mobile_be/pages/announcement/announcement_detail.dart';
import 'package:mobile_be/pages/announcement/announcement_screen.dart';
import 'package:mobile_be/pages/attendance/attendancescreen.dart';
import 'package:mobile_be/pages/authentication/forgot_password_screen.dart';
import 'package:mobile_be/pages/authentication/insert_new_password.dart';
import 'package:mobile_be/pages/authentication/login_screen_teacher.dart';
import 'package:mobile_be/pages/profiles/profilescreen.dart';
import 'package:mobile_be/pages/settings/settings.dart';
import 'package:mobile_be/pages/superadmin/classes/class_screen.dart';
import 'package:mobile_be/pages/dashboard/dashboard_screen.dart';
import 'package:mobile_be/pages/grade/choose-class_screen.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/pages/superadmin/admin-dashboard.dart';

import 'package:mobile_be/pages/superadmin/teachers/teacher_screen.dart';
import 'package:mobile_be/providers/Locale_provider.dart';
import 'package:mobile_be/utils/decode-jwt.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseHost = '192.168.171.62';
const String basePort = '3006';
Future LoggedInRole() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  Map<String, dynamic> _jwtPayload = {"for_type": 'login'};
  if (token != null) {
    _jwtPayload = decodeJwtPayload(token);
  }

  return _jwtPayload['for_type'] != null ? _jwtPayload['for_type'] : '';
}

Future<Locale> savedLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString('selectedLanguage') ?? 'English';
  return savedLanguage == 'Indonesian'
      ? Locale('id', 'ID')
      : Locale('en', 'US');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  AwesomeNotifications().initialize(
    'resource://drawable/notif_icon',
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          channelShowBadge: true,
          importance: NotificationImportance.Low,
          defaultColor: const Color.fromARGB(255, 221, 148, 80),
          ledColor: Colors.white),
    ],
  );
  final currentLocale = await savedLanguage();
  final loggedIn = await LoggedInRole();

  runApp(MainApp(
    isLoggedIn: loggedIn,
    initLocale: currentLocale,
  ));
}

class MainApp extends StatelessWidget {
  final Locale initLocale;
  final String isLoggedIn;
  const MainApp(
      {super.key, required this.isLoggedIn, required this.initLocale});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(initLocale),
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            locale: localeProvider.locale,
            debugShowCheckedModeBanner: false,
            home: isLoggedIn == 'homeroom_teacher'
                ? const Dashboard()
                : isLoggedIn == 'subject_teacher'
                    ? DashboardSubjTeacher()
                    : ChooseRoleScreen(),
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(
                      builder: (context) => const ChooseRoleScreen());
                case '/login-teacher':
                  return MaterialPageRoute(
                      builder: (context) => LoginPageTeacher());
                case '/choose-teacher-role':
                  return MaterialPageRoute(
                      builder: (context) => const ChooseTeacherRoleScreen());
                case '/forgot-password':
                  return MaterialPageRoute(
                      builder: (context) => const ForgotPassword());
                case '/dashboard':
                  return MaterialPageRoute(
                      builder: (context) => const Dashboard());
                case '/dashboard-subj-teacher':
                  return MaterialPageRoute(
                      builder: (context) => const DashboardSubjTeacher());
                case '/dashboard-student':
                  return MaterialPageRoute(
                      builder: (context) => const DashboardStudent());
                case '/insert-new-password':
                  return MaterialPageRoute(
                      builder: (context) => const InsertNewPassword());
                case '/attendance':
                  return MaterialPageRoute(
                      builder: (context) => const AttendanceScreen());
                case '/grade':
                  return MaterialPageRoute(
                      builder: (context) => PickSubjectPage(
                            classId: '',
                          ));
                case '/choose-class-grade':
                  return MaterialPageRoute(
                      builder: (context) => const ChooseClassPage());
                case '/admin-page':
                  return MaterialPageRoute(
                      builder: (context) => const SuperadminDashboard());
                case '/announcements':
                  return MaterialPageRoute(
                      builder: (context) => const AnnouncementScreen());
                case '/schedule':
                  return MaterialPageRoute(
                      builder: (context) => const Schedulescreen());
                case '/student-profiles':
                  return MaterialPageRoute(
                      builder: (context) => const ProfileScreen());
                case '/report':
                  return MaterialPageRoute(
                      builder: (context) => StudentReport());
                case '/announcements/detail':
                  final args = settings.arguments as Map<String, dynamic>;
                  return MaterialPageRoute(
                    builder: (context) => AnnouncementDetail(
                      title: args['title'],
                      image: args['image'],
                      description: args['description'],
                      date: args['date'],
                      file_url: '',
                    ),
                  );
                case '/settings':
                  return MaterialPageRoute(
                      builder: (context) => const Settings());
                default:
                  return MaterialPageRoute(
                      builder: (context) => const ChooseRoleScreen());
              }
            },
          );
        },
      ),
    );
  }
}
