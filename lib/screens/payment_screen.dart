import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Payment",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            tooltip: "Back",
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 20),
              // alignment: Alignment.center,
              // width: 150,
              // height: 150,
              // decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Colors.yellow,
              //     boxShadow: [
              //       // BoxShadow(
              //       //   spreadRadius: 1,
              //       //   blurRadius: 20,
              //       //   color: Colors.black26,
              //       // )
              //     ]),
              child: Column(
                children: [
                  Text('The total amount is'),
                  Text(
                    '\$235.00',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Card(
                elevation: 4.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        onTap: () {},
                        title: Text('Google Pay'),
                        //   subtitle: Text('Pay the order with google pay.'),
                        leading: Icon(Icons.g_translate_sharp),
                        trailing: Icon(Icons.arrow_right),
                      ),
                    ),
                    Divider(),
                    // ListTile(
                    //   title: Text('Card Payment'),
                    //   //subtitle: Text('Credit Card, Debit Card'),
                    //   leading: Icon(Icons.credit_card_rounded),
                    //   trailing: Icon(Icons.arrow_right),
                    // ),
                    // Divider(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        onTap: () {},
                        title: Text('Cash On Delivery'),
                        //   subtitle: Text('Pay at doorstep'),
                        leading: Icon(Icons.monetization_on),
                        trailing: Icon(Icons.arrow_right),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
