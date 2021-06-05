import 'package:delivery/util/const.dart';
import 'package:delivery/widgets/smooth_star_rating.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final String name;
  final String image;
  final double price;

  SearchItem(this.name, this.image, this.price);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "$name",
        style: TextStyle(
//                    fontSize: 15,
          fontWeight: FontWeight.w900,
        ),
      ),
      leading: CircleAvatar(
        radius: 25.0,
        backgroundImage: NetworkImage(
          "$image",
        ),
      ),
      //trailing: Text(r"$10"),
      subtitle: Text("\$$price"),
      // Row(
      //   children: <Widget>[
      //     SmoothStarRating(
      //       starCount: 1,
      //       color: Constants.ratingBG,
      //       allowHalfRating: true,
      //       rating: 5.0,
      //       size: 12.0,
      //     ),
      //     SizedBox(width: 6.0),
      //     Text(
      //       "5.0 (23 Reviews)",
      //       style: TextStyle(
      //         fontSize: 12,
      //         fontWeight: FontWeight.w300,
      //       ),
      //     ),
      //   ],
      // ),
      onTap: () {},
    );
  }
}
