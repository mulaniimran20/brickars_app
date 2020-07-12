import 'dart:convert';

import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _showPassword = false;
  var _email = TextEditingController();
  var _password = TextEditingController();



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
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin: EdgeInsets.symmetric(vertical: 65, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 10), blurRadius: 20)
                      ]),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Text('Sign In', style: Theme.of(context).textTheme.display2),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        decoration: new InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.6)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).focusColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        obscureText: !_showPassword,
                        controller: _password,
                        decoration: new InputDecoration(
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.6)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.padlock_1,
                            color: Theme.of(context).focusColor.withOpacity(0.6),
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
                      /*FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot your password ?',
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
                      SizedBox(height: 30),*/
                      FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: () async {
                          String emailId = _email.text;
                          String passwordF = _password.text;

                          var url = 'https://www.brickars.com/app_api/login.php';
                          var response = await http.post(url, body: {'email': emailId, 'password': passwordF});

                          if(response.statusCode == 200) {
                            var jsondecoded = json.decode(response.body);
                            bool status = jsondecoded['status'];
                            String msg = jsondecoded['msg'];
                            if (status == true) {
                              loginSuccess(jsondecoded['loginid'], jsondecoded['email']);
                             
                              Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 1);
                            }
                            else {

                            }
                          }
                          else{
                            //BotToast.showText(text: "Network Error, Please Try Again");
                          }

                          // 2 number refer the index of Home page

                        },
                        child: Text(
                          'Login',
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
              onPressed: () {
                Navigator.of(context).pushNamed('/SignUp');
              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    TextSpan(text: 'Don\'t have an account ?'),
                    TextSpan(text: ' Sign Up', style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginSuccess(String loginuserid, String loginuseremail) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool('bricksuserlogin', true);
      await prefs.setString('bricksloginuserid', loginuserid);
      await prefs.setString('bricksloginuseremail', loginuseremail);

  }

}
