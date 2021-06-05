import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key key,
    @required TextEditingController usernameControl,
    @required String hintText,
  })  : _usernameControl = usernameControl,
        hintText = hintText,
        super(key: key);

  final TextEditingController _usernameControl;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: TextField(
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
            prefixIcon: Icon(
              Icons.perm_identity,
              color: Colors.black,
            ),
          ),
          maxLines: 1,
          controller: _usernameControl,
        ),
      ),
    );
  }
}
