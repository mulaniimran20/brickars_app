
import 'dart:io';

import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/single_listing_details.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product_color.dart';
import '../widgets/PopularLocationCarouselWidget.dart';
import 'package:flutter/material.dart';
import '../models/utilities.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';


// ignore: must_be_immutable
class ProductDetailWidget extends StatefulWidget {
  SingleListingDetails utilitie;

  ProductDetailWidget({this.utilitie});

  @override
  ProductDetailWidgetState createState() => ProductDetailWidgetState();
}

class ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  Widget build(BuildContext context) {

    List<Widget> listWid = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          leading: Icon(
            UiIcons.chat_1,
            color: Theme.of(context).hintColor,
          ),
          title: Text(
            'Prouct List',
            overflow: TextOverflow.fade,
            softWrap: false,
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
    ];

    for(int i = 0; i< widget.utilitie.productList.length; i++)
      {
        Product p = widget.utilitie.productList[i];

        Widget w = Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                width: 80,
                height: 80,
                child: ClipRRect(
                  child:  widget.utilitie.productList[i].productImageUrl == null || widget.utilitie.productList[i].productImageUrl == "" ? Image.asset("img/placeholder.png",fit: BoxFit.cover,) : FadeInImage.assetNetwork(placeholder: 'img/loading1.gif', image: widget.utilitie.productList[0].productImageUrl,fit: BoxFit.cover,),
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      widget.utilitie.productList[i].productName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      widget.utilitie.productList[i].productCost == null || widget.utilitie.productList[i].productCost == "" ? "N/A" : widget.utilitie.productList[i].productCost,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              )

            ],
          ),
        );
        Widget w1 = SizedBox(height: 10.0,);

        setState(() {
          listWid.add(w);
          listWid.add(w1);
        });


      }


    return
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

       widget.utilitie.serviceProductList == null || widget.utilitie.serviceProductList == "" ? Container() : Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
            ],
          ),
          child: Column(
            children: <Widget>[
                Html(
                data: "<h3><center>Product / Service List</center></h3><br>"+widget.utilitie.serviceProductList,
                //Optional parameters:
                style: {
                  "html" : Style(
                      padding: EdgeInsets.symmetric(vertical: 10.0)
                  ),
                  "li": Style(
                    fontSize: FontSize(14.0),
            //              color: Colors.white,
                  ),
                },)
            ],
          ),
        ),

        widget.utilitie.productList.length == 0 ? Container() : Column(
          children: listWid,
        ),

      ],
    );
  }
}

class SelectColorWidget extends StatefulWidget {
  SelectColorWidget({
    Key key,
  }) : super(key: key);

  @override
  _SelectColorWidgetState createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  ProductColorsList _productColorsList = new ProductColorsList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_productColorsList.list.length, (index) {
        var _color = _productColorsList.list.elementAt(index);
        return buildColor(_color);
      }),
    );
  }

  SizedBox buildColor(ProductColor color) {
    return SizedBox(
      width: 38,
      height: 38,
      child: FilterChip(
        label: Text(''),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: color.color,
        selectedColor: color.color,
        selected: color.selected,
        shape: StadiumBorder(),
        avatar: Text(''),
        onSelected: (bool value) {
          setState(() {
            color.selected = value;
          });
        },
      ),
    );
  }
}



