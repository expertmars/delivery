import 'package:delivery/providers/configs.dart';
import 'package:delivery/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/app_provider.dart';
import './screens/splash.dart';
import './util/const.dart';

import 'package:firebase_core/firebase_core.dart';

import 'util/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        ),
        ChangeNotifierProvider<Products>(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider<Config>(
          create: (context) => Config(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: Firebase.initializeApp(),
    //     builder: (ctx, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }

    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
          darkTheme: Constants.darkTheme,
          home: SplashScreen(),
        );
      },
    );
    // });
  }
}
