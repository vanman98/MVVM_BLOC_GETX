import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:temp/src/notification/notification.dart';

import 'src/base/bloc.dart';
import 'src/translations/app_translations.dart';
import 'src/constants/constants.dart';
import 'src/routes/app_pages.dart';
import 'src/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  await AppPrefs.instance.initListener();
  _initialBlocs();
  await initializeNotification();
  bloc.Bloc.observer = AppBlocObserver();
  runApp(const OverlaySupport(child: App()));
}

void _initialBlocs() {
  Get.put(
    AuthBloc(),
    permanent: true,
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _AppState state = context.findAncestorStateOfType<_AppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      _locale = getLocale();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ScreenUtilInit(
        designSize: orientation == Orientation.portrait
            ? const Size(1080, 1920)
            : const Size(1920, 1080),
        minTextAdapt: true,
        builder: (_, child) {
          return getx.GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.INITIAL,
            theme: AppThemes.appTheme,
            defaultTransition: getx.Transition.fadeIn,
            getPages: AppPages.pages,
            locale: _locale,
            translationsKeys: AppTranslation.translations,
          );
        },
      );
    });
  }
}
