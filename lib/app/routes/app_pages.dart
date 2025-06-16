import 'package:get/get.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/details/binding/call_log_detail_binding.dart';
import '../modules/details/views/call_details_view.dart';
import '../modules/login/binding/auth_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
      // transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
      // transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => CallDetailsView(),
      binding: CallLogDetailBinding(),
      // transition: Transition.leftToRightWithFade,
    ),
  ];
}

