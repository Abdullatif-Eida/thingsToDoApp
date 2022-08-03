import 'package:flutter/material.dart';
import 'package:thingstodoapp/view/ui/Login.dart';
import 'package:thingstodoapp/view/ui/homePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //Our Providers
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Log in',
      theme: ThemeData(
        primaryColor: Color(0XFF6035D0),
        accentColor: const Color(0XFF6035D0),
        colorScheme: ColorScheme.light(
          primary: const Color(0XFF6035D0),
        ),
      ),
      home: Login(),
    );
  }
}
