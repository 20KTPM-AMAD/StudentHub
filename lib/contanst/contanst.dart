import 'package:studenthub/pages/browse_project/project_list_screen.dart';
import 'package:studenthub/pages/chat/message_list_screen.dart';
import 'package:studenthub/pages/company_reviews_proposal/dashboard_screen.dart';
import 'package:studenthub/pages/notification/notification_screen.dart';
import 'package:studenthub/pages/student_submit_proposal/all_projects_screen.dart';

var BottomNavigationCompany = {
  0: const ProjectListScreen(),
  1: const DashboardScreen(),
  2: const MessageListScreen(),
  3: const NotificationScreen()
};

var BottomNavigationStudent = {
  0: const ProjectListScreen(),
  1: const AllProjectsScreen(),
  2: const MessageListScreen(),
  3: const NotificationScreen()
};

enum UserRole { Student, Company }

enum TypeFlag { New, Working, Archieved }

String studentHubUrl = 'https://api.studenthub.dev/api';