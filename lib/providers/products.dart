import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _productList = [];
  List<String> _favoriteProductIds = [];

  List<String> get getfavoriteProductIds => this._favoriteProductIds;

  List<Product> get getProducts {
    return [..._productList];
  }

  void addProduct(Product prod) {
    _productList.add(prod);
  }

  Product getProduct(id) {
    return _productList.firstWhere((products) => products.id == id) ?? null;
  }

  List<Product> productsFromQuerySnapshot(QuerySnapshot query) {
    return query.docs.map((e) {
      return Product(
        id: e.id,
        name: e['product_name'],
        price: double.parse(e['product_price']),
        quanity: int.parse(e['quanity']),
        stock: int.parse(e['stock']),
        imageUrl: e['image_url'],
        description: e['description'],
        unit: e['unit'],
        categoryId: int.parse(e['categoryId']),
      );
      // List<Product> newProds =
      //     _productList.where((prod) => prod.id != p.id).toList();
      // _productList += newProds;
      //return p;
    }).toList();
  }

  List<Product> getProductWithIds(List<String> prodIds) {
    List<Product> products = [];
    prodIds.map((pid) {
      var p = _productList.firstWhere((product) => product.id == pid);
      products.add(p);
    }).toList();

    return products;
  }

  void fetchAllProducts() async {
    print('Fetching all products from firebase');
    var firestore = FirebaseFirestore.instance;
    var querySnapshot = await firestore.collection('products').get();
    _productList = productsFromQuerySnapshot(querySnapshot);
  }

  void toggleFavorite(String productId) {
    Product product =
        _productList.firstWhere((product) => product.id == productId);
    bool check = isFavorite(productId);
    if (!check) {
      _favoriteProductIds.add(product.id);
    } else {
      int index = _favoriteProductIds.indexWhere((id) => id == productId);
      _favoriteProductIds.removeAt(index);
    }
    notifyListeners();
  }

  isFavorite(String productId) {
    bool check = _favoriteProductIds.any((id) => id == productId);
    return check;
  }
}

// List<User> _userList = [];
// String _uid;

// class Users {
//   static addUser(User user) {
//     _userList.add(user);
//   }

//   static List<User> get getUsers {
//     return [..._userList];
//   }

//   static updateUser(String uid,
//       {String name, Map<String, double> location, String imageUrl}) {
//     User selectedUser = _userList.firstWhere((u) => u.uid == uid);

//     String newName = selectedUser.name;
//     String newMobile = selectedUser.mobile;
//     Map<String, double> newLocation = selectedUser.location;
//     String newImageUrl = selectedUser.imageUrl;

//     if (name != null) {
//       newName = name;
//     }

//     if (location != null) {
//       newLocation = location;
//     }

//     if (imageUrl != null) {
//       newImageUrl = imageUrl;
//     }

//     User updatedUser = User(
//       uid: uid,
//       name: newName,
//       location: newLocation,
//       mobile: newMobile,
//       imageUrl: newImageUrl,
//     );

//     final userIndex = _userList.indexWhere((u) => u.uid == uid);
//     _userList[userIndex] = updatedUser;

//     print(' === AFTER ' + _userList.length.toString());

//     for (var user in _userList) printUser(user);
//   }

//   static printUser(User user) {
//     print(user.name);
//     print(user.mobile);
//     print(user.location.toString());
//     print(user.imageUrl);
//     print(user.uid);
//   }

//   static setuid(String uid) {
//     _uid = uid;
//   }

//   static String get getUserId {
//     return _uid;
//   }
// }
