import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/product.dart';
import 'package:delivery/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/notifications.dart';
import '../util/foods.dart';
import '../widgets/badge.dart';
import '../widgets/grid_product.dart';

class DishesScreen extends StatefulWidget {
  @override
  _DishesScreenState createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  List<Product> _products;

  @override
  void initState() {
    super.initState();
    setState(() {
      _products = Provider.of<Products>(context, listen: false).getProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Dishes",
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Text(
              "Chinese",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            // GridView.builder(
            //   shrinkWrap: true,
            //   primary: false,
            //   physics: NeverScrollableScrollPhysics(),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: MediaQuery.of(context).size.width /
            //         (MediaQuery.of(context).size.height / 1.25),
            //   ),
            //   itemCount: 4,
            //   itemBuilder: (BuildContext context, int index) {
            //     Map food = foods[index];
            //     return GridProduct(
            //       img: food['img'],
            //       isFav: false,
            //       name: food['name'],
            //       rating: 5.0,
            //       raters: 23,
            //     );
            //   },
            // ),
            FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('products').get(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:
                        _products.length, //foods == null ? 0 : foods.length,
                    itemBuilder: (BuildContext context, int index) {
//
                      return GridProduct(
                        img: _products[index].imageUrl,
                        name: _products[index].name,
                        productId: _products[index].id,
                      );
                    },
                  );
                }),
            SizedBox(height: 20.0),
            Text(
              "Italian",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            // GridView.builder(
            //   shrinkWrap: true,
            //   primary: false,
            //   physics: NeverScrollableScrollPhysics(),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: MediaQuery.of(context).size.width /
            //         (MediaQuery.of(context).size.height / 1.25),
            //   ),
            //   itemCount: 4,
            //   itemBuilder: (BuildContext context, int index) {
            //     Map food = foods[index];
            //     return GridProduct(
            //       img: food['img'],
            //       isFav: false,
            //       name: food['name'],
            //       rating: 5.0,
            //       raters: 23,
            //     );
            //   },
            // ),
            SizedBox(height: 20.0),
            Text(
              "African",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            // GridView.builder(
            //   shrinkWrap: true,
            //   primary: false,
            //   physics: NeverScrollableScrollPhysics(),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: MediaQuery.of(context).size.width /
            //         (MediaQuery.of(context).size.height / 1.25),
            //   ),
            //   itemCount: 4,
            //   itemBuilder: (BuildContext context, int index) {
            //     Map food = foods[index];
            //     return GridProduct(
            //       img: food['img'],
            //       isFav: false,
            //       name: food['name'],
            //       rating: 5.0,
            //       raters: 23,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
