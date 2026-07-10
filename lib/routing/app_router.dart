import 'package:go_router/go_router.dart';
import 'package:tozher/features/auth/presentation/pages/auth_complete_profile_page.dart';
import 'package:tozher/features/auth/presentation/pages/auth_login_page.dart';
import 'package:tozher/features/auth/presentation/pages/auth_register_page.dart';
import 'package:tozher/features/auth/presentation/pages/auth_send_password_reset_email_page.dart';
import 'package:tozher/features/core/presentation/page/no_route_found_page.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_get_cubit.dart';
import 'package:tozher/features/goals/presentation/pages/goal_add_page.dart';
import 'package:tozher/features/home/presentation/page/home_layout.dart';
import 'route_paths.dart';
import 'route_names.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: RoutePaths.login,
      routes: [
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (_, _) => const AuthLoginPage(),
        ),
        GoRoute(
          path: RoutePaths.register,
          name: RouteNames.register,
          builder: (_, _) => const AuthRegisterPage(),
        ),
        GoRoute(
          path: RoutePaths.sendEmail,
          name: RouteNames.sendEmail,
          builder: (_, _) => const AuthSendPasswordResetEmailPage(),
        ),
        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          builder: (_, state) {
            return HomeLayout();
          },
        ),
        GoRoute(
          path: RoutePaths.completeProfile,
          name: RouteNames.completeProfile,
          builder: (_, state) {
            final userUid = state.extra as String;
            return AuthCompleteProfilePage(userUid: userUid);
          },
        ),
        GoRoute(
          path: RoutePaths.addGoal,
          name: RouteNames.addGoal,
          builder: (_, state) {
            final cubit = state.extra as GoalGetCubit;
            return GoalAddPage(goalGetCubit: cubit);
          },
        ),
      ],
      errorBuilder: (context, state) => const NoRouteFoundPage(),
    );
  }
}
