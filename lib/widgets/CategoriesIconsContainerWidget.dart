import 'package:brickars/models/route_argument.dart';
import 'package:brickars/widgets/CategoryIconWidget.dart';

import '../models/category.dart';
import 'package:flutter/material.dart';

class CategoriesIconsContainerWidget extends StatefulWidget {

  CategoriesIconsContainerWidget({
    Key key, 
    this.categoriesList,
    this.onPressed
    }) :super(key: key);

  final ValueChanged<String> onPressed;
  final List<Category> categoriesList;



  @override
  _CategoriesIconsContainertState createState() => _CategoriesIconsContainertState(categoriesList : categoriesList);
}

class _CategoriesIconsContainertState extends State<CategoriesIconsContainerWidget> {
  _CategoriesIconsContainertState({
    this.categoriesList,
  });

 final List<Category> categoriesList;
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children:_buildSuggestions(categoriesList,context)
        ),
    );
  }
}
  _buildSuggestions(List<Category> list,BuildContext context) {
    List<Widget> categories = List();
      list.forEach((item) {
      categories.add(
        Container(
          padding: EdgeInsets.only(bottom: 20),
          child: CategoryIconWidget(
            category: item,
            onPressed: (id) {
              Navigator.of(context).pushNamed('/Categorie', arguments: new RouteArgument(id: item.id, argumentsList: [item]));
            },
          ),
        ),
      );
    }
    );return categories;
  }