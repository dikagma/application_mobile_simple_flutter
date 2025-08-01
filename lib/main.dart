import 'package:flutter/material.dart';

import 'global/global.parameters.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes:  GlobalParameters.routes,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 22,color: Colors.deepOrange),),

      ),

    );
  }
}

