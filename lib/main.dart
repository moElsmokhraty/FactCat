import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routing/routes.dart';
import 'core/routing/app_router.dart';

void main() {
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
