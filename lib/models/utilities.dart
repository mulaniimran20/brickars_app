import 'dart:convert';
import 'dart:io';

import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/get_network_data.dart';
import 'package:flutter/material.dart';
class Utilitie{
  String id;
  String name;
  String image;
  String type;
  int available;

  Utilitie(this.id, this.name, this.image,this.type,this.available);


}
class UtilitiesList {
  List<Utilitie> _popularList;
  List<Utilitie> _list;
  List<Utilitie> _favoritesList;
  List<Utilitie> _cartList;

  //set recentList(List<Utilitie> value) {
    //_recentList = value;
  //}




  UtilitiesList() {
  }
}