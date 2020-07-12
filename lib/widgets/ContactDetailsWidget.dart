
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


// ignore: must_be_immutable
class ContactDetailsWidget extends StatefulWidget {
  SingleListingDetails utilitie;

  ContactDetailsWidget({this.utilitie});

  @override
  ContactDetailsWidgetState createState() => ContactDetailsWidgetState();
}

class ContactDetailsWidgetState extends State<ContactDetailsWidget> {

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }





  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                leading: Icon(UiIcons.user_1),
                title: Text(
                  'Contact Details',
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
              widget.utilitie.name == null || widget.utilitie.name == "" ? Container() : ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Name',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  child: Text(
                    widget.utilitie.name,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                  width: 150.0,
                ),
              ),
              widget.utilitie.contactPersonName == null || widget.utilitie.contactPersonName == "" ? Container() : ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Contact Person Name',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  child: Text(
                    widget.utilitie.contactPersonName,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                  width: 150.0,
                ),
              ),
              widget.utilitie.contactNumber == null || widget.utilitie.contactNumber == "" ? Container() : ListTile(
                onTap: () async{

                  var number = "0"+widget.utilitie.contactNumber; //set the number here

                  bool res = await FlutterPhoneDirectCaller.callNumber(number);
                },
                dense: true,
                title: Text(
                  'Contact Number',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing:  Container(
                  alignment: Alignment.center,
                  child: Icon(UiIcons.phone_call,),
                  width: 150.0,
                ),
              ),
              widget.utilitie.emailId == null || widget.utilitie.emailId == "" ? Container() : ListTile(
                onTap: () {
                  launch('mailto:'+widget.utilitie.emailId);
                },
                dense: true,
                title: Text(
                  'Email',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  alignment: Alignment.center,
                  child: Icon(UiIcons.mail),
                  width: 150.0,
                ),
              ),
              widget.utilitie.listingAddress == null || widget.utilitie.listingAddress == "" ? Container() : ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Address',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                  child: Text(
                    widget.utilitie.listingAddress,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).focusColor, fontSize: 8.0),
                  ),
                  width: 150.0,
                ),
              ),
              widget.utilitie.service_available_in == null || widget.utilitie.service_available_in == "" ? ListTile() : ListTile(
                onTap: () async{
                  launchInBrowser("https://www.brickars.com/"+widget.utilitie.profile_pdf_link);
                },
                dense: true,
                title: Text(
                  'Service Available Area',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                    alignment: Alignment.center,
                    width: 150.0,
                    child: Container(
                      child: Text(
                        widget.utilitie.service_available_in,
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                      width: 150.0,
                    ),
                ),
              ),
              widget.utilitie.websiteLisnk == null || widget.utilitie.websiteLisnk == "" ? Container() : ListTile(
                onTap: (){
                  launchInBrowser(widget.utilitie.websiteLisnk);
                },
                dense: true,
                title: Text(
                  'Website',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                    alignment: Alignment.center,
                    width: 150.0,
                    child: Icon(Icons.open_in_browser)
                ),
              ),
              widget.utilitie.profile_pdf_link == null || widget.utilitie.profile_pdf_link == "" ? Container() : ListTile(
                onTap: () async{
                  launchInBrowser("https://www.brickars.com/"+widget.utilitie.profile_pdf_link);
                },
                dense: true,
                title: Text(
                  'Profile PDF',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Container(
                    alignment: Alignment.center,
                    width: 150.0,
                    child: Icon(Icons.picture_as_pdf)
                ),
              ),
            ],
          ),
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



