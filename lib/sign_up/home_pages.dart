
import 'package:flutter/material.dart';
import 'package:mobile_app_hack/appTheme.dart';
import 'package:mobile_app_hack/home.dart';
import 'package:mobile_app_hack/sign_up/sign_up.dart';

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabs = [
      1,
      2,
      3,
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.bg,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 25,
                color: AppTheme.primary1,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppTheme.primary1,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppTheme.mix_button_sin_in),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 15, color: AppTheme.white),
                  )),
            )
          ],
          bottom: TabBar(
            labelStyle: TextStyle(color: AppTheme.primary1, fontSize: 20),
            indicatorColor: AppTheme.primary1,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorWeight: 3,
            tabs: [
              Text(
                'Location',
                style: TextStyle(color: AppTheme.primary1, fontSize: 20),
              ),
              Text(
                'Account',
                style: TextStyle(color: AppTheme.primary1, fontSize: 20),
              ),
              Text(
                'Verify',
                style: TextStyle(color: AppTheme.primary1, fontSize: 20),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SignUp(),
            Text(
              'Account',
              style: TextStyle(color: AppTheme.primary1, fontSize: 20),
            ),
            Text(
              'Verify',
              style: TextStyle(color: AppTheme.primary1, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
