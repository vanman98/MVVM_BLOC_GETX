import 'package:get/get.dart';
import '../presentation/presentation.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => SplashScreen(),
    ),
    GetPage(
        name: Routes.NAVIGATION,
        page: () => NavigationScreen(),
        binding: BindingsBuilder.put(() => NavigationBloc())),
  ];
}

abstract class Routes {
  static const INITIAL = '/';

  static const LOGIN = '/login';

  static const NAVIGATION = '/navigation';
}
