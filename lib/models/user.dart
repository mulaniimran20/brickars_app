import 'dart:convert';
import 'dart:io';

import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/get_network_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';

enum UserState { available, away, busy }

class User {
  String id = UniqueKey().toString();
  String name;
  String email;
  String gender;
  DateTime dateOfBirth;
  String avatar;
  String address;
  String contactNumber;
  UserState userState;
  var pincode;
  var userId;

  GetNetworkData getNetworkData = new GetNetworkData();
  UrlList urlList = new UrlList();

  User.init();

  User.basic(this.name, this.avatar, this.userState);

  User.advanced(this.userId, this.name, this.email, this.gender, this.dateOfBirth, this.avatar, this.address, this.contactNumber, this.userState, this.pincode);

  Future<User> getCurrentUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.get("bricksloginuserid");
    String getSingleUserDetails = urlList.getUserDetails+"$userid";

    HttpClientResponse httpClientResponse = await getNetworkData.getNetworkDataUsingGetMethid(getSingleUserDetails);
    if (httpClientResponse.statusCode == 200) {
      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);
      if (response['msg'] == "success") {

          var json = response['data'][0];
          var pincode = json['user_pincode'];
          var address = json['user_address'];
          var fulladd = "$address";
          return User.advanced(userid, json['user_name'], json['user_email_id'], 'Male', DateTime(1992, 18, 10), 'img/user2.jpg',
              fulladd, json['user_mobile_number'], UserState.available, pincode);
        }
      else{
        return User.advanced(userid, 'AARFAA TECHNOVISION PVT LTD', 'admin@aarfaatechnovision.com', 'Male', DateTime(1992, 18, 10), 'img/user2.jpg',
            'Pune, MH, India','86009558210', UserState.available, "411048");
      }
      }

  }

  User getTempUser() {
    return User.advanced('0','AARFAA TECHNOVISION PVT LTD', 'admin@aarfaatechnovision.com', 'Male', DateTime(1992, 10, 18), 'img/user2.jpg',
        'Pune, MH, India', '8600955821', UserState.available, "411048");
  }

  getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(this.dateOfBirth);
  }
}
