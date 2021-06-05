import 'package:delivery/screens/address_screen.dart';
import 'package:flutter/material.dart';
import '../providers/local_user.dart';

class NameScreen extends StatefulWidget {
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _nameController = TextEditingController();
  bool error = false;

  updateUser() {
    LocalUser.updateUser(newName: _nameController.text);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => AddressScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your name'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                controller: _nameController,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  errorText: error
                      ? "Please enter a valid name eg. Firstname LastName"
                      : null,
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300],
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Full Name",
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                onChanged: (value) {
                  if (value.isEmpty)
                    setState(() {
                      error = false;
                    });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('Next'),
              onPressed: () {
                if (!_nameController.text
                    .trimLeft()
                    .trimRight()
                    .contains(" ")) {
                  setState(() {
                    error = true;
                  });
                  return;
                }

                setState(() {
                  error = false;
                });

                updateUser();
              },
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor),
            ),
          ],
        ),
      ),
    );
  }
}
