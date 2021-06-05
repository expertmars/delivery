import 'package:delivery/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/details.dart';
import '../util/const.dart';
import '../widgets/smooth_star_rating.dart';

class GridProduct extends StatelessWidget {
  final String name;
  final String img;
  final String productId;

  GridProduct(
      {Key key,
      @required this.name,
      @required this.img,
      @required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Products provider = Provider.of<Products>(context);
    bool isFav = provider.isFavorite(productId);
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.6,
                width: MediaQuery.of(context).size.width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: -10.0,
                bottom: 3.0,
                child: RawMaterialButton(
                  onPressed: () {
                    provider.toggleFavorite(productId);
                  },
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_outlined,
                      color: Colors.red,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0, right: 7.0),
            child:
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                Text(
              "$name",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
            // Text(
            //   "\$22",
            //   style: TextStyle(
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.w900,
            //   ),
            //   maxLines: 2,
            // ),
            //   ],
            // ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            child: Text(
              "\$22",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            // Row(
            //   children: <Widget>[
            //     SmoothStarRating(
            //       starCount: 5,
            //       color: Constants.ratingBG,
            //       allowHalfRating: true,
            //       rating: rating,
            //       size: 10.0,
            //     ),
            //     Text(
            //       " $rating ($raters Reviews)",
            //       style: TextStyle(
            //         fontSize: 11.0,
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails(productId);
            },
          ),
        );
      },
    );
  }
}
