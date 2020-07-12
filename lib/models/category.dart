import 'dart:convert';

import 'package:brickars/config/ui_icons.dart';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import '../models/utilities.dart';

class Category {
  int id;
  String name;
  bool selected;
  IconData icon;
  Color color;
  List<Utilitie> utilities; 

  Category(this.id, this.name, this.icon, this.selected,this.color, this.utilities);
}

class SubCategory {
  String id = "1";
  String name;
  bool selected;
  List<Utilitie> utilities;

  SubCategory(this.name, this.selected, this.utilities);
}


