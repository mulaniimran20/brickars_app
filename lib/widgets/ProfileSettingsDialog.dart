import 'dart:convert';

import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/user.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;

class ProfileSettingsDialog extends StatefulWidget {
  User user;
  VoidCallback onChanged;

  ProfileSettingsDialog({Key key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(UiIcons.user_1),
                    SizedBox(width: 10),
                    Text(
                      'Profile Settings',
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'John Doe', labelText: 'Full Name'),
                          initialValue: widget.user.name,
                          validator: (input) => input.trim().length < 3 ? 'Not a valid full name' : null,
                          onSaved: (input) => widget.user.name = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(hintText: 'johndo@gmail.com', labelText: 'Email Address'),
                          initialValue: widget.user.email,
                          validator: (input) => !input.contains('@') ? 'Not a valid email' : null,
                          onSaved: (input) => widget.user.email = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.multiline,
                          decoration: getInputDecoration(hintText: 'Enter Address', labelText: 'Address'),
                          initialValue: widget.user.address,
                          validator: (input) => !(input.length > 5) ? 'Not a valid Address' : null,
                          onSaved: (input) => widget.user.address = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.number,
                          decoration: getInputDecoration(hintText: 'Pincode', labelText: 'Pincode'),
                          initialValue: widget.user.pincode,
                          validator: (input) => !(input.length == 6) ? 'Not a valid pincode' : null,
                          onSaved: (input) => widget.user.pincode = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.phone,
                          decoration: getInputDecoration(hintText: 'Mobile Number', labelText: 'Mobile Number'),
                          initialValue: widget.user.contactNumber,
                          validator: (input) => !(input.length >= 10) ? 'Not a valid contact' : null,
                          onSaved: (input) => widget.user.contactNumber = input,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Text(
        "Edit",
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }



  void _submit() async{
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();

      var userName = widget.user.name;
      var userEmail = widget.user.email;
      var userAddress = widget.user.address;
      var userPincode = widget.user.pincode;
      var userContactNumber = widget.user.contactNumber;
      var userId = widget.user.userId;

      var body = {'userId':userId, 'userName': userName, 'userEmail': userEmail, "userAddress":userAddress, "userPincode":userPincode, "userMobileNumber" : userContactNumber};

      UrlList urlList = new UrlList();
      var url = urlList.updateUserDetails;
      var response = await http.post(url, body: body);

      print(body.toString());

      if(response.statusCode == 200) {
        var jsondecoded = json.decode(response.body);
        bool status = jsondecoded['status'];
        String msg = jsondecoded['msg'];
        Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 1);
      }


    }
  }
}
