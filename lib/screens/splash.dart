import 'dart:async';
import 'package:delivery/providers/configs.dart';
import 'package:delivery/providers/products.dart';
import 'package:delivery/screens/join.dart';
import 'package:delivery/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../screens/walkthrough.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/const.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isIntroCompleted = false;
  startTimeout() {
    return Timer(Duration(seconds: 2), changeScreen);
  }

  fetchData() {
    Provider.of<Products>(context, listen: false).fetchAllProducts();
    Provider.of<Config>(context, listen: false).fetchAllConfig();
  }

  getIntroCompleteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isIntroCompleted')) {
      _isIntroCompleted = true;
    }
  }

  checkAuthStatus() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        if (authSnapshot.hasData) {
          if (authSnapshot.connectionState == ConnectionState.active) {
            if (authSnapshot.data != null) {
              print('He was looged iin');
              return MainScreen();
            } else {
              print('Logged out');
              return JoinApp();
            }
          }
        }
      },
    );
  }

  changeScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return _isIntroCompleted ? checkAuthStatus() : Walkthrough();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    getIntroCompleteStatus();
    fetchData();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.fastfood,
                size: 150.0,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 40.0),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  "${Constants.appName}",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
