import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../screens/register.dart';
import 'package:flutter/services.dart';

class JoinApp extends StatefulWidget {
  @override
  _JoinAppState createState() => _JoinAppState();
}

class _JoinAppState extends State<JoinApp> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 1);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.keyboard_backspace,
        //   ),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          // indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          tabs: <Widget>[
            // Tab(
            //   text: "Login",
            // ),
            Tab(
              text: "Sign In",
            ),
          ],
        ),
      ),
      // body: FutureBuilder(
      //   future: Firebase.initializeApp(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     return TabBarView(
      //       controller: _tabController,
      //       children: <Widget>[
      //         // LoginScreen(),
      //         RegisterScreen(),
      //       ],
      //     );
      //   },
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          // LoginScreen(),
          RegisterScreen(),
        ],
      ),
      // ),
    );
  }
}
