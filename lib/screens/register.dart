import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/screens/name_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:otp_screen/otp_screen.dart';
import '../screens/main_screen.dart';
import './address_screen.dart';

import '../providers/local_user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _mobileControl = new TextEditingController();

  UserCredential user;

  String _mobile = "";
  String _fullname = "";

  void moveToNextScreen(context) {
    if (user == null) {
      return;
    }
    if (user.additionalUserInfo.isNewUser) {
      //Registration.
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('users').doc(user.user.uid).set({
        'mobile': user.user.phoneNumber,
      });

      LocalUser.updateUser(
          newUid: user.user.uid, newMobile: user.user.phoneNumber);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => NameScreen()));
    } else {
      // Logging In
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => MainScreen()));
    }
  }

  void verifyCode(String verificationId, int forceResendToken) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return OtpScreen(
              otpLength: 6,
              validateOtp: (String otp) async {
                await Future.delayed(Duration(milliseconds: 2000));
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otp);
                  FirebaseAuth auth = FirebaseAuth.instance;
                  final result = await auth.signInWithCredential(credential);

                  user = result;
                  return null;
                } catch (e) {
                  print(e);
                  return "Something went wrong";
                }

                // if (otp == "1234") {
                //   return null;
                // } else {
                //   return "The entered Otp is wrong";
                // }
              },
              routeCallback: moveToNextScreen);
        },
      ),
    );
  }

  onSubmit() {
    if (!formKey.currentState.validate()) {
      print('Not Validated');
      return;
    }

    formKey.currentState.save();
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _mobile,
      verificationCompleted: (PhoneAuthCredential credentials) {
        // Only for android, signing in automatically by this callback.
        auth.signInWithCredential(credentials);
      },
      verificationFailed: (error) {
        print(error);
      },
      codeSent: verifyCode,
      codeAutoRetrievalTimeout: (String verificationId) {
        print('autoretreval timeout');
      },
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Processing your data')));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Image.asset('assets/delivery.jpg'),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 25.0,
              ),
              child: Text(
                "Connect your account",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(height: 30.0),

            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty || value.length < 10 || value.length > 10) {
                    return "Please give a valid mobile number.";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _mobile = "+91" + newValue;
                },
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300],
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300],
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Mobile Number",
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Text("+91",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _mobileControl,
              ),
            ),
            // SizedBox(height: 10.0),
            // Card(
            //   elevation: 3.0,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(5.0),
            //       ),
            //     ),
            //     child: TextField(
            //       style: TextStyle(
            //         fontSize: 15.0,
            //         color: Colors.black,
            //       ),
            //       decoration: InputDecoration(
            //         contentPadding: EdgeInsets.all(10.0),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5.0),
            //           borderSide: BorderSide(
            //             color: Colors.white,
            //           ),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //             color: Colors.white,
            //           ),
            //           borderRadius: BorderRadius.circular(5.0),
            //         ),
            //         hintText: "Password",
            //         prefixIcon: Icon(
            //           Icons.lock_outline,
            //           color: Colors.black,
            //         ),
            //         hintStyle: TextStyle(
            //           fontSize: 15.0,
            //           color: Colors.black,
            //         ),
            //       ),
            //       obscureText: true,
            //       maxLines: 1,
            //       controller: _passwordControl,
            //     ),
            //   ),
            // ),
            SizedBox(height: 40.0),
            Container(
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  "GET OTP".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: onSubmit,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(height: 10.0),
//           Divider(
//             color: Theme.of(context).accentColor,
//           ),
//           SizedBox(height: 10.0),
//           Center(
//             child: Container(
//               width: MediaQuery.of(context).size.width / 2,
//               child: Row(
//                 children: <Widget>[
//                   RawMaterialButton(
//                     onPressed: () {},
//                     fillColor: Colors.blue[800],
//                     shape: CircleBorder(),
//                     elevation: 4.0,
//                     child: Padding(
//                       padding: EdgeInsets.all(15),
//                       child: Icon(
//                         FontAwesomeIcons.facebookF,
//                         color: Colors.white,
// //              size: 24.0,
//                       ),
//                     ),
//                   ),
//                   RawMaterialButton(
//                     onPressed: () {},
//                     fillColor: Colors.white,
//                     shape: CircleBorder(),
//                     elevation: 4.0,
//                     child: Padding(
//                       padding: EdgeInsets.all(15),
//                       child: Icon(
//                         FontAwesomeIcons.google,
//                         color: Colors.blue[800],
// //              size: 24.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
