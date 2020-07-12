import 'dart:convert';
import 'dart:io';

import 'package:brickars/config/ui_icons.dart';
import 'package:brickars/models/UrlList.dart';
import 'package:brickars/models/get_network_data.dart';
import 'package:brickars/models/single_listing_details.dart';

import '../models/product_color.dart';
import '../widgets/PopularLocationCarouselWidget.dart';
import 'package:flutter/material.dart';
import '../models/utilities.dart';
// ignore: must_be_immutable
class UtilitieHomeTabWidget extends StatefulWidget {
  SingleListingDetails utilitie;
  String displayopenhours = "";
  UtilitieHomeTabWidget({this.utilitie});

  @override
  UtilitieHomeTabWidgetState createState() => UtilitieHomeTabWidgetState();
}

class UtilitieHomeTabWidgetState extends State<UtilitieHomeTabWidget> {

  List<Utilitie> listUt = [];
  Widget recomndationWidget = Container();
  Future<List<Utilitie>> getPopularListData(String id) async {
    List<Utilitie> listRecomendation = [];
    UrlList urlList = new UrlList();
    GetNetworkData getNetworkData = new GetNetworkData();
    String categoriesHomePageData = urlList.getSingleListingDetailsRelatedSuggestion+id;
    HttpClientResponse httpClientResponse = await getNetworkData
        .getNetworkDataUsingGetMethid(categoriesHomePageData);
    if (httpClientResponse.statusCode == 200) {
      String reply = await httpClientResponse.transform(utf8.decoder).join();
      var response = jsonDecode(reply);
      if (response['msg'] == "success") {
        for (int i = 0; i < response['loop']; i++) {
          var jsob = response['data'][i];
          if(i == (response['loop'] - 1)) {
            listRecomendation.add(
              new Utilitie(
                  jsob['listing_id'], jsob['listing_name'], jsob['site_home_page_image_url'],
                  jsob['sub_category_name'], 25),
            );
            setState(() {
              listUt = listRecomendation;
              recomndationWidget = PopularLocationCarouselWidget(heroTag: 'product_related_products', utilitiesList: listUt);
            });
          }
          else{
            listRecomendation.add(
              new Utilitie(
                  jsob['listing_id'], jsob['listing_name'], jsob['site_home_page_image_url'],
                  jsob['sub_category_name'], 12),
            );
          }
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopularListData(widget.utilitie.id);
  }



  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 22, left: 20, right: 20),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.utilitie.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.display2,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.utilitie.type,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.body2
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              ListTile(
                leading: Icon(UiIcons.information),
                title: Text(
                  'Company Details',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              widget.utilitie.establishmentYear == null || widget.utilitie.establishmentYear == "" ? Container() : ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Establishment Year',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  child: Text(
                    widget.utilitie.establishmentYear,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                  width: 150.0,
                ),
              ),
              widget.utilitie.gstNumber == null || widget.utilitie.gstNumber == "" ? Container() : ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'GST No.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  child: Text(
                    widget.utilitie.gstNumber,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                  width: 150.0,
                ),
              ),
              widget.utilitie.openHours == null || widget.utilitie.listingAddress == "" ? Container() : ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Office Open Hours',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  child: Text(
                    widget.utilitie.openHours.split(",").length > 0 && widget.utilitie.openHours.split(",").length == 1 ? widget.utilitie.openHours.split(",")[0] : widget.utilitie.openHours.split(",").length > 0 && widget.utilitie.openHours.split(",").length == 2 ? widget.utilitie.openHours.split(",")[0]+"\n"+widget.utilitie.openHours.split(",")[1] : widget.utilitie.openHours,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).focusColor, fontSize: 8.0),
                  ),
                  width: 150.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  UiIcons.file_2,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Description',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                widget.utilitie.description
              )
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Related',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        recomndationWidget,
        //PopularLocationCarouselWidget(heroTag: 'product_related_products', utilitiesList: widget._productsList.popularList),
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



