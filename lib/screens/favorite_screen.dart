import 'package:delivery/models/product.dart';
import 'package:delivery/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/foods.dart';
import '../widgets/grid_product.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin<FavoriteScreen> {
  List<String> _favoriteProductIds = [];
  List<Product> _favoriteProducts = [];

  Products provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Products>(context);

    _favoriteProductIds = provider.getfavoriteProductIds;
    _favoriteProducts = provider.getProductWithIds(_favoriteProductIds);
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "My Favorite Items",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),
            _favoriteProducts.isEmpty
                ? Center(
                    child: Text('No Favorites yet'),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount: _favoriteProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GridProduct(
                        img: _favoriteProducts[index].imageUrl,
                        name: _favoriteProducts[index].name,
                        productId: _favoriteProducts[index].id,
                      );
                    },
                  ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
