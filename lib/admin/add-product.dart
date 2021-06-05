import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();

  String _productName = "";
  String _productPrice = "";
  String _quantity = "";
  String _stock = "";
  String _unit = "";
  String _imageUrl = "";
  String _description = "";
  String _categoryId = "";

  onFormSubmit() async {
    formKey.currentState.save();
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final result = await firestore.collection('products').add({
        'product_name': _productName,
        'product_price': _productPrice,
        'quanity': _quantity,
        'stock': _stock,
        'unit': _unit,
        'image_url': _imageUrl,
        'description': _description,
        'categoryId': _categoryId,
      });
      formKey.currentState.reset();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Added 1 product'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong'),
      ));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add products'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 35,
          ),
          child: Container(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AdminFormField(
                        label: "Product Name",
                        onSave: (val) {
                          _productName = val;
                        },
                      ),
                      SizedBox(height: 20),
                      AdminFormField(
                        label: "Price",
                        onSave: (val) {
                          _productPrice = val;
                        },
                      ),
                      SizedBox(height: 20),
                      AdminFormField(
                        label: "Quantity",
                        onSave: (val) {
                          _quantity = val;
                        },
                      ),
                      SizedBox(height: 20),
                      AdminFormField(
                        label: "Stock",
                        onSave: (val) {
                          _stock = val;
                        },
                      ),
                      SizedBox(height: 20),
                      AdminFormField(
                        label: "Unit",
                        onSave: (val) {
                          _unit = val;
                        },
                      ),
                      SizedBox(height: 20),
                      AdminFormField(
                        label: "ImageUrl",
                        onSave: (val) {
                          _imageUrl = val;
                        },
                      ),
                      SizedBox(height: 20),
                      AdminFormField(
                        label: "Description",
                        onSave: (val) {
                          _description = val;
                        },
                      ),
                      SizedBox(height: 20),
                      AdminFormField(
                        label: "Category Id",
                        onSave: (val) {
                          _categoryId = val;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: onFormSubmit, child: Text('Add')),
                    ],
                  ))),
        ),
      ),
    );
  }
}

class AdminFormField extends StatelessWidget {
  AdminFormField({@required this.label, this.onSave, this.onValidate});

  final String label;
  final void Function(String) onValidate;
  final void Function(String) onSave;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onValidate,
      onSaved: onSave,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
    );
  }
}
