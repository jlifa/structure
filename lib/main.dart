import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_pages.dart';
import 'translation/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  runApp(
      ScreenUtilInit(
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        designSize: const Size(393,852),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Roboto'),
            title: "Application",
            translations: Translation(),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            fallbackLocale: const Locale("en"),
        //    initialBinding: MainBinding(),
            builder: FlutterSmartDialog.init(),
          );
        },
      )

  );
}