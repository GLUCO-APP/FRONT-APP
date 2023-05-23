import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gluko/login/view/login_page.dart';


void main()  {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(canvasColor: Colors.white, fontFamily: "GlukoFamily", brightness: Brightness.light, colorScheme: ColorScheme.light(primary: Colors.red)),
      home: Loginpage(),
    );
  }
}





