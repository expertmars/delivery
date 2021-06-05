import 'package:flutter/foundation.dart';

class LocalUser {
  static String uid;
  static String name;
  static String mobile;
  static Map<String, double> location;
  static String imageUrl;

  static updateUser(
      {String newUid,
      String newMobile,
      String newName,
      Map<String, double> newLocation,
      String newImageUrl}) {
    if (newUid != null) {
      uid = newUid;
    }

    if (newMobile != null) {
      mobile = newMobile;
    }

    if (newName != null) {
      name = newName;
    }

    if (newLocation != null) {
      location = newLocation;
    }

    if (newImageUrl != null) {
      imageUrl = newImageUrl;
    }
    print('User Updated Locally');
    print(name);
    print(imageUrl);
    print(location);
    print(mobile);
    print(uid);
  }

  static String get getName {
    return name;
  }

  static Map<String, double> get getLocation {
    return location;
  }

  // static String get getUserId {
  //   return this._uid;
  // }
}
