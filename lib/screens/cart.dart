import 'package:delivery/models/product.dart';
import 'package:delivery/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/checkout.dart';
import '../util/foods.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin<CartScreen> {
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
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView.builder(
          itemCount: _products.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return CartItem(
              img: _products[index].imageUrl,
              name: _products[index].name,
              id: _products[index].id,
              price: _products[index].price,
              quantity: _products[index].quanity,
              unit: _products[index].unit,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Checkout",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Checkout();
              },
            ),
          );
        },
        child: Icon(
          Icons.arrow_forward,
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
