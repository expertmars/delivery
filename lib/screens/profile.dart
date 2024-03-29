import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/admin/add-product.dart';
import 'package:delivery/screens/test_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../screens/splash.dart';
import '../util/const.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: firestore.collection('users').doc(auth.currentUser.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          Map<String, dynamic> userData = snapshot.data.data();
          return Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Image.network(
                        userData['image_url'],
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                userData['full_name'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                //"jane@doefamily.com",
                                auth.currentUser.phoneNumber,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  auth.signOut();
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (BuildContext context) {
                                  //       return SplashScreen();
                                  //     },
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      flex: 3,
                    ),
                  ],
                ),
                Divider(),
                Container(height: 15.0),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Account Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Full Name",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    "Jane Mary Doe",
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 20.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => TestScreen()));
                    },
                    tooltip: "Edit",
                  ),
                ),
                ListTile(
                  title: Text(
                    "Admin Panel",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    "Sign in to your admin panel",
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => AddProduct()),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "Phone",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    "+1 816-926-6241",
                  ),
                ),
                ListTile(
                  title: Text(
                    "Address",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    "1278 Loving Acres RoadKansas City, MO 64110",
                  ),
                ),
                ListTile(
                  title: Text(
                    "Gender",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    "Female",
                  ),
                ),
                ListTile(
                  title: Text(
                    "Date of Birth",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    "April 9, 1995",
                  ),
                ),
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? SizedBox()
                    : ListTile(
                        title: Text(
                          "Dark Theme",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: Switch(
                          value: Provider.of<AppProvider>(context).theme ==
                                  Constants.lightTheme
                              ? false
                              : true,
                          onChanged: (v) async {
                            if (v) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .setTheme(Constants.darkTheme, "dark");
                            } else {
                              Provider.of<AppProvider>(context, listen: false)
                                  .setTheme(Constants.lightTheme, "light");
                            }
                          },
                          activeColor: Theme.of(context).accentColor,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
