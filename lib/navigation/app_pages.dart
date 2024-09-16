import 'package:get/get.dart';
import 'package:icourseapp/screens/account_screens/blogs/blogs_bindings.dart';
import 'package:icourseapp/screens/account_screens/blogs/blogs_screen.dart';
import 'package:icourseapp/screens/account_screens/contact_us/contact_us_screen.dart';
import 'package:icourseapp/screens/account_screens/qrcode/qrcode_bindings.dart';
import 'package:icourseapp/screens/account_screens/qrcode/qrcode_screen.dart';
import 'package:icourseapp/screens/announcement/announcement_bindings.dart';
import 'package:icourseapp/screens/announcement/announcement_screen.dart';
import 'package:icourseapp/screens/auth/register/register_bindings.dart';
import 'package:icourseapp/screens/auth/register/register_screen.dart';
import 'package:icourseapp/screens/categories/categories_bindings.dart';
import 'package:icourseapp/screens/categories/categories_screen.dart';
import 'package:icourseapp/screens/courses/categories_courses_bindings.dart';
import 'package:icourseapp/screens/courses/categories_courses_screen.dart';
import 'package:icourseapp/screens/courses/course_details/course_details_bindings.dart';
import 'package:icourseapp/screens/courses/course_details/course_details_screen.dart';
import 'package:icourseapp/screens/courses/course_details/screens/rate/rate_bindings.dart';
import 'package:icourseapp/screens/courses/course_details/screens/rate/rate_screen.dart';
import 'package:icourseapp/screens/files/files_bindings.dart';
import 'package:icourseapp/screens/files/files_screen.dart';
import 'package:icourseapp/screens/filtered_courses/filtered_course_bindings.dart';
import 'package:icourseapp/screens/filtered_courses/filtered_course_screen.dart';
import 'package:icourseapp/screens/forgeot_password/email_send/email_send_bindings.dart';
import 'package:icourseapp/screens/forgeot_password/email_send/email_send_screen.dart';
import 'package:icourseapp/screens/forgeot_password/pin/phone_pin_screen.dart';
import 'package:icourseapp/screens/forgeot_password/reset_password/reset_password_bindings.dart';
import 'package:icourseapp/screens/forgeot_password/reset_password/reset_password_screen.dart';
import 'package:icourseapp/screens/home/home_bindings.dart';
import 'package:icourseapp/screens/home/home_screen.dart';
import 'package:icourseapp/screens/home/tabs/chat/details/chat_details_screen.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_bindings.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_screen.dart';
import 'package:icourseapp/screens/lectures/lectures_bindings.dart';
import 'package:icourseapp/screens/lectures/lectures_screen.dart';
import 'package:icourseapp/screens/notification/notification_bindings.dart';
import 'package:icourseapp/screens/notification/notification_screen.dart';
import 'package:icourseapp/screens/organization/organizations_bindings.dart';
import 'package:icourseapp/screens/organization/organizations_screen.dart';
import 'package:icourseapp/screens/quezzeis/quezzies_bindings.dart';
import 'package:icourseapp/screens/quezzeis/quezzies_screen.dart';
import 'package:icourseapp/screens/quezzeis/quiz_details/quiz_details_screen.dart';
import 'package:icourseapp/screens/splash/splash_bindings.dart';
import 'package:icourseapp/screens/splash/splash_screen.dart';
import 'package:icourseapp/screens/sub_categories/sub_categories_screen.dart';
import 'package:icourseapp/screens/user_guide/user_guide_bindings.dart';
import '../screens/account_screens/contact_us/contact_us_bindings.dart';
import '../screens/account_screens/privacy/privacy_bindings.dart';
import '../screens/account_screens/privacy/privacy_screen.dart';
import '../screens/auth/login/auth_bindings.dart';
import '../screens/auth/login/auth_screen.dart';
import '../screens/forgeot_password/pin/phone_pin_bindings.dart';
import '../screens/home/tabs/chat/details/chat_details_bindings.dart';
import '../screens/quezzeis/quiz_details/quiz_details_bindings.dart';
import '../screens/search/search_screen.dart';
import '../screens/sub_categories/sub_categories_bindings.dart';
import '../screens/user_guide/user_guide_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        binding: SplashBindings()),

    GetPage(
        name: Routes.userGuide,
        page: () => UserGuideScreen(),
        binding: UserGuideBindings()),

    GetPage(
        name: Routes.auth,
        page: () => AuthScreen(),
        binding: AuthBindings()),

    GetPage(
        name: Routes.home,
        page: () => HomeScreen(),
        binding: HomeBindings()),

    GetPage(
        name: Routes.categories,
        page: () => CategoriesScreen(),
        binding: CategoriesBindings()),

    GetPage(
        name: Routes.categoriesCourses,
        page: () => CategoriesCoursesScreen(),
        binding: CategoriesCoursesBindings()),

    GetPage(
        name: Routes.courseDetails,
        page: () => CourseDetailsScreen(),
        binding: CourseDetailsBindings()),

    GetPage(
        name: Routes.lectures,
        page: () => LecturesScreen(),
        binding: LecturesBindings()),

    GetPage(
        name: Routes.lecturesDetails,
        page: () => LecturesDetailsScreen(),
        binding: LecturesDetailsBindings()),

    GetPage(
        name: Routes.rate,
        page: () => RateScreen(),
        binding: RateBindings()),
    GetPage(
        name: Routes.files,
        page: () => FileScreen(),
        binding: FilesBindings()),

    GetPage(
        name: Routes.announcement,
        page: () => AnnouncementScreen(),
        binding: AnnouncementBindings()),

    GetPage(
        name: Routes.blogs,
        page: () => BlogsScreen(),
        binding: BlogsBindings()),

    GetPage(
        name: Routes.terms,
        page: () => PrivacyScreen(),
        binding: PrivacyBindings()),

    GetPage(
        name: Routes.register,
        page: () => RegisterScreen(),
        binding: RegisterBindings()),

    GetPage(
        name: Routes.subCategory,
        page: () => SubCategoriesScreen(),
        binding: SubCategoriesBindings()),

    GetPage(
        name: Routes.filteredCourse,
        page: () => FilteredCourseScreen(),
        binding: FilteredCourseBindings()),

    GetPage(
        name: Routes.contact,
        page: () => ContactUsScreen(),
        binding: ContactUsBindings()),

    GetPage(
        name: Routes.quiz,
        page: () => QuizzesScreen(),
        binding: QuezziesBindings()),

    GetPage(
        name: Routes.quizDetails,
        page: () => QuizDetailsScreen(),
        binding: QuizBindings()),

    GetPage(
        name: Routes.notification,
        page: () => NotificationScreen(),
        binding: NotificationBindings()),

    GetPage(
        name: Routes.qrCode,
        page: () => QRCodeScreen(),
        binding: QRCodeBindings()),

    GetPage(
        name: Routes.chatDetails,
        page: () => ChatDetailsScreen(),
        binding: ChatDetailsBindings()),
    GetPage(
        name: Routes.search,
        page: () => SearchScreen(),),
    GetPage(
        name: Routes.email,
        page: () => EmailSendScreen(),
        binding: EmailSendBindings()),

    GetPage(
        name: Routes.pin,
        page: () => PhonePinScreen(),
        binding: PhonePinBindings()),

    GetPage(
        name: Routes.resetPassword,
        page: () => ResetPasswordScreen(),
        binding: ResetPasswordBindings()),

    GetPage(
        name: Routes.organizations,
        page: () => OrganizationsScreen(),
        binding: OrganizationsBindings()),

  ];
}
