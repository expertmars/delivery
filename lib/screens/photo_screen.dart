import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/providers/local_user.dart';
import 'package:delivery/screens/home.dart';
import 'package:delivery/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File _storedImage;

  updateImage(File image) {
    setState(() {
      _storedImage = image;
    });
  }

  takePicture() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 600.0);

    updateImage(image);
  }

  fromGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 600.0);

    updateImage(image);
  }

  moveToNextScreen([bool continueUpload = false]) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
    // If Continue with image.
    if (continueUpload) {
      updateUserToDB();
    }
  }

  Future<void> updateUserToDB() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseStorage fbs = FirebaseStorage.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = auth.currentUser;
      final ref = fbs.ref().child('user_images').child(user.uid + '.jpg');

      await ref.putFile(_storedImage);

      final url = await ref.getDownloadURL();
      LocalUser.updateUser(newImageUrl: url);
      final location = LocalUser.getLocation;

      GeoPoint geo = GeoPoint(location['latitude'], location['longitude']);
      var uid = auth.currentUser.uid;
      firestore.collection('users').doc(uid).set({
        "mobile": user.phoneNumber,
        "full_name": LocalUser.getName,
        "location": geo,
        "image_url": url,
      });
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Take a picture of landmark',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      height: 200,
                      width: double.infinity,
                      child: _storedImage != null
                          ? Image.file(_storedImage)
                          : Image.asset('assets/placeholder.jpg')),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: takePicture,
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor),
                          child: Text('Take Picture'),
                        ),
                        ElevatedButton(
                          onPressed: fromGallery,
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor),
                          child: Text('Select Image'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Please take picture of your resident / building to deliver. This will be used as a reference to understand the delivery location',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  // fontWeight: FontWeight.bold,

                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: moveToNextScreen,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => moveToNextScreen(true),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
