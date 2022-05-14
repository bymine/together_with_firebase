import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:together_with_firebase/src/bindings/app_binding.dart';
import 'package:together_with_firebase/src/bindings/init_binding.dart';
import 'package:together_with_firebase/src/components/splash_screen.dart';
import 'package:together_with_firebase/src/controllers/add_project_controller.dart';
import 'package:together_with_firebase/src/controllers/add_schedule_controller.dart';
import 'package:together_with_firebase/src/pages/app.dart';
import 'package:together_with_firebase/src/pages/login_page.dart';
import 'package:together_with_firebase/src/pages/sign_up_page.dart';
import 'package:together_with_firebase/src/pages/views/add_project_page.dart';
import 'package:together_with_firebase/src/pages/views/add_schedule_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      initialRoute: '/',
      initialBinding: InitBindings(),
      getPages: [
        GetPage(name: '/', page: () => const SplashPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signUp', page: () => const SignUpPage()),
        GetPage(name: '/app', page: () => const App(), binding: AppBinding()),
        GetPage(
            name: '/addProject',
            page: () => const AddProjectPage(),
            binding: BindingsBuilder.put(() => AddProjectController())),
        GetPage(
            name: '/addSchedule',
            page: () => const AddSchedulePage(),
            binding: BindingsBuilder.put(() => AddScheduleController())),
      ],
    );
  }
}
