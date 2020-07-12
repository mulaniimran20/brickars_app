import 'dart:convert';

import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/UrlList.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _showPassword = false;

  var userFullName;
  var userEmailAddress;
  var userAddress;
  var userContactNumber;
  var userPincode;
  var userPasswrod;

  var _userFullNameController = TextEditingController();
  var _userEmailAddressController = TextEditingController();
  var _userAddressController = TextEditingController();
  var _userContactNumberController = TextEditingController();
  var _userPincodeController = TextEditingController();
  var _userPasswrodController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 30),
                  margin: EdgeInsets.fromLTRB(20,45,20,20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 10), blurRadius: 20)
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Text('Sign Up', style: Theme.of(context).textTheme.display2),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        controller: _userFullNameController,
                        decoration: new InputDecoration(
                          hintText: 'Full Name',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                            TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        controller: _userContactNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          hintText: 'Contact Number',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                            TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        controller: _userPincodeController,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: 'PIN Code',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                            TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        controller: _userEmailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        controller: _userAddressController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          hintText: 'Address',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                            TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        controller: _userPasswrodController,
                        obscureText: !_showPassword,
                        decoration: new InputDecoration(
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.padlock_1,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: () async{
                          userFullName = _userFullNameController.text;
                          userEmailAddress = _userEmailAddressController.text;
                          userContactNumber = _userContactNumberController.text;
                          userAddress = _userAddressController.text;
                          userPasswrod = _userPasswrodController.text;
                          userPincode = _userPincodeController.text;

                          var usernametrue = false;
                          var useremailtrue = false;
                          var usercontacttrue = false;
                          var useraddresstrue = false;
                          var userpasswordtrue = false;
                          var userpincodetrue = false;



                          if(userFullName.length < 3)
                            {
                              Toast.show("Please Enter Correct Name", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }
                          else{
                            usernametrue = true;
                          }



                          if(!userEmailAddress.contains('@'))
                            {
                              Toast.show("Please Enter Correct Email ID", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }
                          else{
                            useremailtrue = true;
                          }


                          if(userPincode.length != 6)
                            {
                              Toast.show("Please Enter Correct Pincode", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }
                          else{
                            userpincodetrue = true;
                          }


                          if(userPasswrod.length < 3)
                            {
                              Toast.show("Please Enter Correct Password", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }
                          else{
                            userpasswordtrue = true;
                          }



                          if(userContactNumber.length < 10)
                            {
                              Toast.show("Please Enter Correct Contact Number", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }
                          else{
                            usercontacttrue = true;
                          }



                          if(userAddress.length < 5)
                            {
                              Toast.show("Please Enter Address", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }
                          else{
                            useraddresstrue = true;
                          }



                          if(usernametrue & useraddresstrue & userpasswordtrue & usercontacttrue & userpincodetrue & useremailtrue) {
                            var body = {
                              "userFullName": userFullName,
                              "userEmailAddress": userEmailAddress,
                              "userContactNumber": userContactNumber,
                              "userAddress": userAddress,
                              "userPasswrod": userPasswrod,
                              "userPincode": userPincode
                            };

                            UrlList urlList = new UrlList();


                            var url = urlList.registerUser;
                            var response = await http.post(url, body: body);

                            if (response.statusCode == 200) {
                              var jsondecoded = json.decode(response.body);
                              print(jsondecoded);
                              bool status = jsondecoded['status'];
                              String msg = jsondecoded['msg'];
                              if (status == true) {
                                Navigator.of(context).pushNamed('/SignIn');
                              }
                              else {

                              }
                            }
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.title.merge(
                                TextStyle(color: Theme.of(context).primaryColor),
                              ),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
            FlatButton(
              onPressed: () async{
                   Navigator.of(context).pushNamed('/SignIn');

              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    TextSpan(text: 'Already have an account ?'),
                    TextSpan(text: ' Sign In', style: TextStyle(fontWeight: FontWeight.w700)),
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
