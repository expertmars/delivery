import 'package:delivery/providers/local_user.dart';
import 'package:delivery/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/photo_screen.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool isDone = false;

  String _imageUrl =
      "https://images.unsplash.com/photo-1569336415962-a4bd9f69cd83?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1778&q=80";

  void _getCurrentLocation() async {
    final locData = await Location().getLocation();
    // String mapImagePreview = LocationHelper.generateLocationPreviewImage(
    //     locData.latitude, locData.longitude);

    setState(() {
      //_imageUrl = mapImagePreview;
      isDone = true;
    });

    LocalUser.updateUser(newLocation: {
      "latitude": locData.latitude,
      "longitude": locData.longitude
    });
  }

  moveToNextScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => PhotoScreen()),
    );
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
            Text(
              'Select your delivery location',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Column(
              children: [
                Container(
                    height: 160,
                    child: Image.network(
                      _imageUrl,
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _getCurrentLocation,
                      icon: Icon(Icons.location_on),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor),
                      label: Text('Current location'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.map),
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).accentColor),
                      label: Text(
                        'Pick location',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => PhotoScreen()));
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: isDone ? moveToNextScreen : null,
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color:
                          isDone ? Theme.of(context).accentColor : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
