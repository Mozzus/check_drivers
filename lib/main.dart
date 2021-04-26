import 'package:check_drivers/elements/logic/card.dart';
import 'package:check_drivers/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CardModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Check Documents App',
        theme: ThemeData(fontFamily: "Inter"),
        home: LoginScreen(),
      ),
    );
  }
}
