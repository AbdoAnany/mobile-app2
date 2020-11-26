import 'package:flutter/material.dart';
import 'package:mobile_app_hack/sign_up/home_pages.dart';

import 'appTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile App Hack',
      theme: ThemeData(
        primaryColor: AppTheme.primary1,
      ),
      home: HomePages(),
    );
  }
}
