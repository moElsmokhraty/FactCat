import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/functions/setup_hive_db.dart';
import 'core/routing/routes.dart';
import 'core/routing/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Future.wait([
    setupHiveDB(),
    ScreenUtil.ensureScreenSize(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);
  runApp(const FactCat());
}

class FactCat extends StatelessWidget {
  const FactCat({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      designSize: const Size(393, 852),
      child: MaterialApp(
        title: 'FactCat',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutes.main,
        theme: ThemeData(fontFamily: 'Bricolage Grotesque'),
      ),
    );
  }
}
