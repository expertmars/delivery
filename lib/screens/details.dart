import 'package:delivery/models/product.dart';
import 'package:delivery/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/notifications.dart';
import '../util/comments.dart';
import '../util/const.dart';
import '../util/foods.dart';
import '../widgets/badge.dart';
import '../widgets/smooth_star_rating.dart';
import '../widgets/grid_product.dart';

class ProductDetails extends StatefulWidget {
  final String productId;

  ProductDetails(this.productId);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Product product;
  List<Product> relatedProducts;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Products provider = Provider.of<Products>(context);
    product = provider.getProduct(widget.productId);
    relatedProducts = provider.getProducts;
    bool isFav = provider.isFavorite(widget.productId);
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
          "Item Details",
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
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: () {
                      provider.toggleFavorite(widget.productId);
                    },
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            //   child: Row(
            //     children: <Widget>[
            //       SmoothStarRating(
            //         starCount: 5,
            //         color: Constants.ratingBG,
            //         allowHalfRating: true,
            //         rating: 5.0,
            //         size: 10.0,
            //       ),
            //       SizedBox(width: 10.0),
            //       Text(
            //         "5.0 (23 Reviews)",
            //         style: TextStyle(
            //           fontSize: 11.0,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "${product.quanity} ${product.unit}",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "\$${product.price.toString()}",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Product Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Related Products",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 20.0),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return GridProduct(
                  img: relatedProducts[index].imageUrl,
                  name: relatedProducts[index].name,
                  productId: relatedProducts[index].id,
                );
              },
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   primary: false,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: comments == null ? 0 : comments.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     Map comment = comments[index];
            //     return ListTile(
            //       leading: CircleAvatar(
            //         radius: 25.0,
            //         backgroundImage: AssetImage(
            //           "${comment['img']}",
            //         ),
            //       ),
            //       title: Text("${comment['name']}"),
            //       subtitle: Column(
            //         children: <Widget>[
            //           Row(
            //             children: <Widget>[
            //               SmoothStarRating(
            //                 starCount: 5,
            //                 color: Constants.ratingBG,
            //                 allowHalfRating: true,
            //                 rating: 5.0,
            //                 size: 12.0,
            //               ),
            //               SizedBox(width: 6.0),
            //               Text(
            //                 "February 14, 2020",
            //                 style: TextStyle(
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.w300,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 7.0),
            //           Text(
            //             "${comment["comment"]}",
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "ADD TO CART",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {},
        ),
      ),
    );
  }
}
